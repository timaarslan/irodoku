import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irodoku/main.dart';

void main() {
  testWidgets('IrodokuApp renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const IrodokuApp());

    expect(find.text('Welcome to Irodoku'), findsOneWidget);
    expect(find.text('New Game'), findsOneWidget);
  });
}
