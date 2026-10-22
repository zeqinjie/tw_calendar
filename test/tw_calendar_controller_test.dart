import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tw_calendar/tw_calendar.dart';
import 'package:tw_calendar/tw_day_number.dart';

void main() {
  Widget calendarFor(TWCalendarController controller) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 375,
            height: 500,
            child: TWCalendarList(calendarController: controller),
          ),
        ),
      ),
    );
  }

  group('controller date range validation', () {
    test('rejects a last date before the first date', () {
      expect(
        () => TWCalendarController(
          firstDate: DateTime(2025, 4, 5),
          lastDate: DateTime(2025, 4, 3),
        ),
        throwsAssertionError,
      );
    });

    test('accepts a selectable range consisting of a single date', () {
      expect(
        () => TWCalendarController(
          firstDate: DateTime(2025, 4, 3),
          lastDate: DateTime(2025, 4, 3),
        ),
        returnsNormally,
      );
    });
  });

  test('updateData is safe before attaching a calendar', () {
    final controller = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
    );
    expect(controller.updateData, returnsNormally);
  });

  test('does not expose a public state getter or setter', () {
    final dynamic controller = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
    );
    expect(() => controller.state, throwsA(isA<NoSuchMethodError>()));
    expect(() => controller.state = null, throwsA(isA<NoSuchMethodError>()));
  });

  testWidgets('updateData is safe after the calendar is disposed',
      (tester) async {
    final controller = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
    );
    await tester.pumpWidget(calendarFor(controller));
    await tester.pumpWidget(const SizedBox.shrink());

    expect(controller.updateData, returnsNormally);
    expect(tester.takeException(), isNull);
  });

  testWidgets('replacing a controller detaches the previous controller',
      (tester) async {
    final first = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
      selectedStartDate: DateTime(2025, 4, 3),
      selectedEndDate: DateTime(2025, 4, 5),
      onSelectDayTitle: (start, end, days) => '$days days',
    );
    final second = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
      selectedStartDate: DateTime(2025, 4, 10),
      selectedEndDate: DateTime(2025, 4, 11),
      onSelectDayTitle: (start, end, days) => '$days days',
    );

    await tester.pumpWidget(calendarFor(first));
    expect(find.text('3 days'), findsOneWidget);

    await tester.pumpWidget(calendarFor(second));
    expect(find.text('2 days'), findsOneWidget);

    second.selectedEndDate = DateTime(2025, 4, 14);
    first.updateData();
    await tester.pumpWidget(calendarFor(second));
    expect(find.text('2 days'), findsOneWidget);

    second.updateData();
    await tester.pumpWidget(calendarFor(second));
    expect(find.text('5 days'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('replacing a controller clears previous nonserial selections',
      (tester) async {
    final first = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
      notSerialSelectedDates: [DateTime(2025, 4, 3)],
    );
    List<DateTime>? finishedDates;
    final second = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
      selectedStartDate: DateTime(2025, 4, 10),
      selectedEndDate: DateTime(2025, 4, 11),
      onSelectFinish: (start, end, dates, days) => finishedDates = dates,
    );
    await tester.pumpWidget(calendarFor(first));
    await tester.pumpWidget(calendarFor(second));

    final days = tester.widgetList<TWDayNumber>(find.byType(TWDayNumber));
    expect(days.singleWhere((day) => day.day == 3).isSelected, isFalse);
    expect(days.singleWhere((day) => day.day == 10).isSelected, isTrue);
    await tester.tap(find.byType(TextButton));
    expect(finishedDates, isEmpty);
    expect(tester.takeException(), isNull);
  });
}
