import 'package:flutter_test/flutter_test.dart';

import 'package:neuroaprende/main.dart';

void main() {
  testWidgets('NeuroAprende inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const NeuroAprendeApp());

    expect(find.text('NeuroAprende'), findsOneWidget);
  });
}