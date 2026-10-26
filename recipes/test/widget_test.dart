import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes/main.dart';

void main() {
  testWidgets('Open a recipe and scale its ingredients', (tester) async {
    await tester.pumpWidget(ReceipesApp());

    expect(find.text('Receipes Calculator'), findsOneWidget);
    await tester.tap(find.text('Spaghetti and Meatballs'));
    await tester.pumpAndSettle();

    expect(find.text('1.0 box Spaghetti'), findsOneWidget);
    expect(find.text('4.0  Frozen Meatballs'), findsOneWidget);
    expect(find.text('0.5 jar sauce'), findsOneWidget);

    await tester.tapAt(tester.getTopRight(find.byType(Slider)) -
        const Offset(24, 0) +
        Offset(0, tester.getSize(find.byType(Slider)).height / 2));
    await tester.pumpAndSettle();

    expect(find.text('10.0 box Spaghetti'), findsOneWidget);
    expect(find.text('40.0  Frozen Meatballs'), findsOneWidget);
    expect(find.text('5.0 jar sauce'), findsOneWidget);
    expect(find.text('0.5 jar sauce'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Receipes Calculator'), findsOneWidget);
    expect(find.byType(Slider), findsNothing);
  });
}
