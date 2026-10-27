import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:focus_track_movil/main.dart';

void main() {
  testWidgets('Incrementa, decrementa y reinicia metas', (tester) async {
    await tester.pumpWidget(const FocusTrackApp());
    expect(find.text('0 / 5'), findsOneWidget);
    expect(find.text('Inicial'), findsOneWidget);

    await tester.tap(find.text('Completar Meta'));
    await tester.pump();
    expect(find.text('1 / 5'), findsOneWidget);
    expect(find.text('En Progreso'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0 / 5'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0 / 5'), findsOneWidget);

    await tester.tap(find.text('Completar Meta'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.restart_alt));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reiniciar'));
    await tester.pumpAndSettle();
    expect(find.text('0 / 5'), findsOneWidget);
    expect(find.text('Metas restablecidas exitosamente.'), findsOneWidget);
  });
}
