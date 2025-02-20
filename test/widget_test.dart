import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersafar/screens/welcome_screen.dart';

void main() {
  testWidgets('Navigation from Welcome to Signup screen', (WidgetTester tester) async {
    // Build the WelcomeScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: WelcomeScreen(),
    ));

    // Verify that the WelcomeScreen contains the 'Get Started' button.
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the 'Get Started' button and trigger navigation.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that the SignupScreen is displayed.
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Sign up as:'), findsOneWidget);
  });
}
