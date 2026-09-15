const { initializeApp } = require('firebase-admin/app');
const { FieldValue, getFirestore } = require('firebase-admin/firestore');
const { getMessaging } = require('firebase-admin/messaging');
const { logger } = require('firebase-functions');
const { onDocumentCreated } = require('firebase-functions/v2/firestore');

initializeApp();

const db = getFirestore();
const channelId = 'transaction_alerts';

function paymentRail(value) {
  const normalized = String(value || '').trim().toLowerCase();
  if (normalized.includes('raast')) return 'Raast Payment';
  if (normalized.includes('easypaisa')) return 'Easypaisa Transfer';
  return 'Bank Transfer';
}

function maskedAccount(value) {
  const compact = String(value || '').replace(/\s+/g, '');
  if (!compact || compact.toLowerCase() === 'notset') return '*******';
  return `*******${compact.slice(-4)}`;
}

function displayDate(value) {
  const date = value && typeof value.toDate === 'function' ? value.toDate() : new Date();
  const two = (part) => String(part).padStart(2, '0');
  const three = (part) => String(part).padStart(3, '0');
  return `${date.getUTCFullYear()}-${two(date.getUTCMonth() + 1)}-${two(date.getUTCDate())} at ` +
    `${two(date.getUTCHours())}:${two(date.getUTCMinutes())}:${two(date.getUTCSeconds())}.${three(date.getUTCMilliseconds())}`;
}

function notificationBody({ ownerName, amount, receiverName, receiverMaskedAccount, rail, ownerMaskedAccount, completedAt, transactionId }) {
  return `Dear ${ownerName}, An amount of Rs. ${Number(amount || 0).toFixed(2)} has been successfully sent to ` +
    `${receiverName} in ${receiverMaskedAccount} via ${rail} from your Easypaisa account ` +
    `${ownerMaskedAccount} on ${completedAt}. Trx ID: ${transactionId}.`;
}

function chunks(items, chunkSize) {
  const result = [];
  for (let index = 0; index < items.length; index += chunkSize) {
    result.push(items.slice(index, index + chunkSize));
  }
  return result;
}

exports.sendTransactionNotification = onDocumentCreated(
  'users/{accountId}/transactions/{transactionDocumentId}',
  async (event) => {
    const transactionSnapshot = event.data;
    if (!transactionSnapshot) return;

    const transaction = transactionSnapshot.data();
    if (transaction.status !== 'success' || transaction.type !== 'debit') return;

    const { accountId, transactionDocumentId } = event.params;
    const transactionId = `TRX-${transactionDocumentId}`;
    const rail = paymentRail(transaction.paymentRail || transaction.bankName);
    const body = notificationBody({
      ownerName: String(transaction.ownerName || 'Customer'),
      amount: transaction.amount,
      receiverName: String(transaction.recipientName || 'the receiver'),
      receiverMaskedAccount: transaction.recipientMaskedAccount || maskedAccount(transaction.recipientAccount),
      rail,
      ownerMaskedAccount: transaction.ownerMaskedAccount || '*******',
      completedAt: transaction.completedAtDisplay || displayDate(transaction.completedAt),
      transactionId,
    });

    const account = db.collection('users').doc(accountId);
    const notification = account.collection('notifications').doc(transactionDocumentId);
    const created = await db.runTransaction(async (databaseTransaction) => {
      const existing = await databaseTransaction.get(notification);
      if (existing.exists) return false;
      databaseTransaction.set(notification, {
        transactionId,
        title: 'Transaction Successful',
        body,
        amount: Number(transaction.amount || 0),
        receiverName: String(transaction.recipientName || ''),
        receiverMaskedAccount: transaction.recipientMaskedAccount || maskedAccount(transaction.recipientAccount),
        ownerName: String(transaction.ownerName || 'Customer'),
        ownerMaskedAccount: transaction.ownerMaskedAccount || '*******',
        paymentRail: rail,
        ownerUid: transaction.ownerUid || null,
        ownerEmail: transaction.ownerEmail || null,
        createdAt: FieldValue.serverTimestamp(),
        readAt: null,
      });
      databaseTransaction.update(transactionSnapshot.ref, {
        transactionId,
        notificationCreatedAt: FieldValue.serverTimestamp(),
      });
      return true;
    });

    // Firestore can retry a create event. The notification document is the idempotency key.
    if (!created) return;

    const deviceSnapshot = await account.collection('devices').where('active', '==', true).get();
    const devices = deviceSnapshot.docs
      .map((document) => ({ reference: document.ref, ...document.data() }))
      .filter((device) => device.platform === 'android' && typeof device.token === 'string' && device.token.length > 0);

    for (const deviceChunk of chunks(devices, 500)) {
      try {
        const response = await getMessaging().sendEachForMulticast({
          tokens: deviceChunk.map((device) => device.token),
          notification: { title: 'Transaction Successful', body },
          data: {
            notificationId: transactionDocumentId,
            transactionId,
            type: 'transaction',
          },
          android: {
            priority: 'high',
            notification: { channelId },
          },
        });
        const invalidDeviceDeletes = [];
        response.responses.forEach((result, index) => {
          const code = result.error && result.error.code;
          if (
            !result.success &&
            (code === 'messaging/registration-token-not-registered' ||
              code === 'messaging/invalid-registration-token')
          ) {
            invalidDeviceDeletes.push(deviceChunk[index].reference.delete());
          }
        });
        await Promise.all(invalidDeviceDeletes);
      } catch (error) {
        // The durable inbox already exists; log delivery failures without retrying a duplicate alert.
        logger.error('Unable to send transaction push notification', error);
      }
    }
  },
);
