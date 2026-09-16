// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easypesa/easypesa_app.dart';

void main() {
  testWidgets('renders the EasyPesa app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const EasyPesaApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('EasyPesa'), findsNothing);
  });

  testWidgets('renders dynamic transfer-success details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TransferSuccessScreen(
          amount: 1250.5,
          bankName: 'Sadapay',
          logoAsset: 'assets/logos/sadapay.webp',
          recipientAccount: '03191981267',
          recipientName: 'Muhammad Sufiyan Rafeeq',
          markAsFavorite: false,
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Rs. 1250.50'), findsOneWidget);
    expect(find.text('Successfully Sent to'), findsOneWidget);
    expect(find.text('Muhammad Sufiyan Rafeeq'), findsOneWidget);
    expect(find.text('03191981267'), findsOneWidget);
    expect(find.text('Back to home'), findsOneWidget);
    expect(find.byTooltip('Share receipt'), findsOneWidget);
    expect(find.byTooltip('View receipt'), findsOneWidget);
  });

  testWidgets('footer actions return home and open the receipt', (
    WidgetTester tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    const successScreen = TransferSuccessScreen(
      amount: 1,
      bankName: 'Sadapay',
      logoAsset: 'assets/logos/sadapay.webp',
      recipientAccount: '03191981267',
      recipientName: 'Muhammad Sufiyan Rafeeq',
      markAsFavorite: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: const Scaffold(body: Center(child: Text('Home'))),
      ),
    );
    navigatorKey.currentState!.push(
      MaterialPageRoute<void>(builder: (_) => successScreen),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back to home'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);

    navigatorKey.currentState!.push(
      MaterialPageRoute<void>(builder: (_) => successScreen),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Share receipt'));
    await tester.pumpAndSettle();
    expect(find.text('Transaction Successful'), findsOneWidget);

    navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('View receipt'));
    await tester.pumpAndSettle();
    expect(find.text('Transaction Successful'), findsOneWidget);
  });
}
