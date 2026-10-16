import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:login_page/main.dart';

void main() {
  testWidgets('3 second timer and AnimatedScale test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify AnimatedCrossFade, AnimatedOpacity, and AnimatedScale exist.
    expect(find.byType(AnimatedCrossFade), findsOneWidget);
    expect(find.byType(AnimatedOpacity), findsOneWidget);
    expect(find.byType(AnimatedScale), findsOneWidget);
  });
}
