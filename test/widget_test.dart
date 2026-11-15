import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillswap/main.dart';

void main() {
  testWidgets('demo login opens the matches page', (tester) async {
    await tester.pumpWidget(const SkillSwapApp());
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('demo@skillswap.edu'), findsOneWidget);

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Find Your Match'), findsOneWidget);
    expect(find.text('Student matches'), findsOneWidget);
  });

  testWidgets('a submitted rating updates the skill passport', (tester) async {
    await tester.pumpWidget(const SkillSwapApp());
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sessions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rate your experience').first);
    await tester.pumpAndSettle();
    final fiveStars = find.bySemanticsLabel('Rate 5 Excellent');
    await tester.ensureVisible(fiveStars);
    await tester.tap(fiveStars);
    await tester.pump();
    expect(find.text('5  ·  Excellent'), findsOneWidget);
    await tester.tap(find.text('Submit Rating'));
    await tester.pumpAndSettle();
    expect(find.text('Rating submitted successfully'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.workspace_premium_outlined).first);
    await tester.pumpAndSettle();
    expect(find.text('3 student ratings'), findsOneWidget);
    expect(find.text('4.7'), findsWidgets);
  });
}
