import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/splash_screen/splash_screen_widget.dart';

void main() {
  // Exercise signed-out navigation without starting the Firebase-backed app root.
  for (final destination in ['Login', 'Register']) {
    testWidgets('Welcome screen opens $destination', (tester) async {
      // Allow room for the full forms with Flutter's wider test font.
      await tester.binding.setSurfaceSize(const Size(800, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(MaterialApp(home: SplashScreenWidget()));

      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);

      await tester.tap(find.text(destination));
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(TextFormField, 'Email Address'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      if (destination == 'Register') {
        expect(find.widgetWithText(TextFormField, 'Full Name'), findsOneWidget);
        expect(find.widgetWithText(TextFormField, 'Confirm Password'),
            findsOneWidget);
        expect(find.text('Create Account'), findsOneWidget);
      } else {
        expect(find.widgetWithText(TextFormField, 'Full Name'), findsNothing);
      }

      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
    });
  }
}
