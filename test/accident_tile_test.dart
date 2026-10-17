import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_emergency_services_pannel/models/accident.dart';
import 'package:fyp_emergency_services_pannel/views/pages/accident/components/accident_tile.dart';

void main() {
  Future<void> openVerificationDialog(
    WidgetTester tester,
    AccidentModel accident,
    Stream<AccidentModel?> accidentUpdates,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: AccidentTile(
              accident: accident,
              accidentUpdates: accidentUpdates,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Accident ID: acc_test'));
    await tester.pumpAndSettle();

    expect(find.text('View video'), findsOneWidget);
    expect(find.text('Open location'), findsOneWidget);
  }

  testWidgets('tile opens a dialog containing all verification fields', (
    tester,
  ) async {
    await openVerificationDialog(
      tester,
      AccidentModel(
        id: 'test',
        verification: AccidentVerificationModel(
          verdict: 'Crash',
          confidence: 0.87,
          severity: 'High',
          incidentTypes: ['Vehicle collision'],
          hazardsDetected: ['Road blocked'],
          reasoningSummary: 'A vehicle struck a barrier.',
          recommendedAction: 'Call emergency services.',
          requiresMoreFrames: true,
          alternativeExplanations: ['Possible medical emergency'],
          visualEvidence: ['Vehicle damage visible'],
        ),
      ),
      Stream.value(
        AccidentModel(
          id: 'test',
          verification: AccidentVerificationModel(
            verdict: 'Crash',
            confidence: 0.87,
            severity: 'High',
            incidentTypes: ['Vehicle collision'],
            hazardsDetected: ['Road blocked'],
            reasoningSummary: 'A vehicle struck a barrier.',
            recommendedAction: 'Call emergency services.',
            requiresMoreFrames: true,
            alternativeExplanations: ['Possible medical emergency'],
            visualEvidence: ['Vehicle damage visible'],
          ),
        ),
      ),
    );

    for (final text in [
      'Verdict',
      'Crash',
      'Confidence',
      '0.87',
      'Severity',
      'High',
      'Incident types',
      'Vehicle collision',
      'Hazards detected',
      'Road blocked',
      'Reasoning summary',
      'A vehicle struck a barrier.',
      'Recommended action',
      'Call emergency services.',
      'Requires more frames',
      'Yes',
      'Alternative explanations',
      'Possible medical emergency',
      'Visual evidence',
      'Vehicle damage visible',
    ]) {
      expect(find.text(text), findsAtLeastNWidgets(1));
    }
  });

  testWidgets('missing verification fields are shown as processing', (
    tester,
  ) async {
    await openVerificationDialog(
      tester,
      AccidentModel(id: 'test'),
      Stream.value(AccidentModel(id: 'test')),
    );

    expect(
      find.textContaining('AI verification is in progress'),
      findsOneWidget,
    );
    expect(find.text('AI is processing...'), findsNWidgets(10));
  });

  testWidgets('dialog updates verification fields from live accident stream', (
    tester,
  ) async {
    final accidentUpdates = StreamController<AccidentModel?>(sync: true);
    addTearDown(accidentUpdates.close);

    await openVerificationDialog(
      tester,
      AccidentModel(id: 'test'),
      accidentUpdates.stream,
    );
    expect(find.text('AI is processing...'), findsNWidgets(10));

    accidentUpdates.add(
      AccidentModel(
        id: 'test',
        verification: AccidentVerificationModel(
          verdict: 'Confirmed crash',
          confidence: 0.94,
          severity: 'High',
          incidentTypes: ['Collision'],
          hazardsDetected: [],
          reasoningSummary: 'Live verification summary',
          recommendedAction: 'Dispatch responders',
          requiresMoreFrames: false,
          alternativeExplanations: [],
          visualEvidence: ['Visible damage'],
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Confirmed crash'), findsOneWidget);
    expect(find.text('Live verification summary'), findsOneWidget);
    expect(find.text('AI is processing...'), findsNothing);
  });
}
