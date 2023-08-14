
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathyGenerator/all_utils.dart';



void main() {
  testWidgets('Widget onTap callback test', (WidgetTester tester) async {
    bool callbackTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: InkWell(
            onTap: () {
              callbackTriggered = true;
            },
            child: AnimatedPadding(
              padding: const EdgeInsets.all(10.0), // Replace with your desired padding value.
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Container(
                alignment: Alignment.center,
                width: 200.0, // Replace with your desired width.
                height: 100.0, // Replace with your desired height.
                color: Colors.blue, // Replace with your desired background color.
                child: const Text('HELLO THERE'), // Replace with your desired child widget.
              ),
            ),
          ),
        ),
      ),
    );

    // Tap the InkWell widget.
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Check if the callback was triggered.
    expect(callbackTriggered, true);
  });
  testWidgets('Widget child content test', (WidgetTester tester) async {
    // Define your test child widget here.
    Widget testChild = const Text('HELLO THERE');

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: InkWell(
            onTap: () {},
            child: AnimatedPadding(
              padding: const EdgeInsets.all(10.0), // Replace with your desired padding value.
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Container(
                alignment: Alignment.center,
                width: 200.0, // Replace with your desired width.
                height: 100.0, // Replace with your desired height.
                color: Colors.blue, // Replace with your desired background color.
                child: testChild,
              ),
            ),
          ),
        ),
      ),
    );

    // Check if the test child is displayed.
    expect(find.text('HELLO THERE'), findsOneWidget);
  });
}
