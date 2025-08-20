import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pos_system/app/app.dart';

void main() {
  testWidgets('POS App loads correctly', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: POSApp(),
      ),
    );

    expect(find.text('ExVen POS'), findsOneWidget);
    expect(find.text('Point of Sale System'), findsOneWidget);
    expect(find.byIcon(Icons.point_of_sale), findsOneWidget);
  });
}
