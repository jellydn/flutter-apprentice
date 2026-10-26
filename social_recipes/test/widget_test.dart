import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_recipes/main.dart';

void main() {
  testWidgets('Navigate from the home card to recipe trends and back',
      (tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Fooderlich'), findsOneWidget);
    expect(find.text('The Art of Dough'), findsOneWidget);
    expect(find.text('Recipe Trends'), findsNothing);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Recipe Trends'), findsOneWidget);
    expect(find.text('Healthy'), findsOneWidget);
    expect(find.text('The Art of Dough'), findsNothing);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('The Art of Dough'), findsOneWidget);
    expect(find.text('Recipe Trends'), findsNothing);
  });

  for (final width in [320.0, 800.0]) {
    testWidgets('Search card keeps its favorite usable at width $width',
        (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 700));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(MyApp());
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.text('Mike Katz'), findsOneWidget);
      expect(find.text('Smoothie Connoisseur'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump();
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pump();
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  }
}
