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

  testWidgets('No supera el límite diario de 10 metas', (tester) async {
    await tester.pumpWidget(const FocusTrackApp());
    for (var i = 0; i < 11; i++) {
      await tester.tap(find.text('Completar Meta'));
      await tester.pump();
    }
    expect(find.text('10 / 5'), findsOneWidget);
    expect(
      find.text('Ha alcanzado el límite máximo diario de metas (10/10). '
          '¡Excelente jornada!'),
      findsOneWidget,
    );
  });

  testWidgets('El selector de prioridad actualiza el panel', (tester) async {
    await tester.pumpWidget(const FocusTrackApp());
    expect(find.textContaining('Prioridad Media.'), findsOneWidget);

    await tester.tap(find.text('Alta'));
    await tester.pump();
    expect(find.textContaining('Prioridad Alta.'), findsOneWidget);
  });
}
