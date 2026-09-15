import 'package:flutter_test/flutter_test.dart';

import 'package:easypesa/transaction_notifications.dart';

void main() {
  group('maskAccountNumber', () {
    test('shows only the final four digits', () {
      expect(maskAccountNumber('03123456789'), '*******6789');
    });

    test('handles short and missing values without exposing data', () {
      expect(maskAccountNumber('2976'), '*******2976');
      expect(maskAccountNumber(''), '*******');
      expect(maskAccountNumber('Not set'), '*******');
    });
  });

  test('uses the correct rail name', () {
    expect(paymentRailForBankName('Raast ID'), 'Raast Payment');
    expect(paymentRailForBankName('Easypaisa Bank'), 'Easypaisa Transfer');
    expect(paymentRailForBankName('Meezan Bank'), 'Bank Transfer');
  });

  test('formats the exact transaction notification template', () {
    final body = formatTransactionNotificationBody(
      ownerName: 'Ayesha Khan',
      amount: 100,
      receiverName: 'Bilal Ahmed',
      receiverMaskedAccount: '*******2976',
      paymentRail: 'Raast Payment',
      ownerMaskedAccount: '*******1267',
      completedAt: DateTime(2026, 9, 10, 16, 8, 20, 754),
      transactionId: 'TRX-55584223243',
    );

    expect(
      body,
      'Dear Ayesha Khan, An amount of Rs. 100.00 has been successfully sent '
      'to Bilal Ahmed in *******2976 via Raast Payment from your Easypaisa '
      'account *******1267 on 2026-09-10 at 16:08:20.754. Trx ID: '
      'TRX-55584223243.',
    );
  });
}
