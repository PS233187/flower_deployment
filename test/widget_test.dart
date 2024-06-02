// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eindopdracht/main.dart';

void main() {
  testWidgets('HomePage displays welcome message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify that our HomePage displays the welcome message.
    expect(find.text('Welkom bij Jazzies Flowers!'), findsOneWidget);
    expect(find.text('Ontdek de mooiste bloemen hier.'), findsOneWidget);
  });
}
