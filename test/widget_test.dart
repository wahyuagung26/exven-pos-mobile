import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jagokasir/app/app.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: JagoKasirApp(),
      ),
    );

    // Wait for splash page to load
    await tester.pump();

    // Verify splash page elements
    expect(find.byIcon(Icons.store), findsOneWidget);
    expect(find.text('JagoKasir'), findsOneWidget);
    
    // Complete any pending timers to clean up
    await tester.pumpAndSettle();
  });
}