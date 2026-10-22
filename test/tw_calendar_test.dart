import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tw_calendar/tw_calendar.dart';
import 'package:tw_calendar/tw_day_number.dart';

void main() {
  testWidgets('today label fits a narrow date cell', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: TWDayNumber(
            size: 50,
            day: 1,
            isSelected: false,
            isToday: true,
            isMaxSelectedDays: false,
            isMinSelectedDays: false,
            dayNumberConfig: TWCalendarDayNumberConfig(todyTitle: 'today'),
          ),
        ),
      ),
    ));
    expect(tester.takeException(), isNull);
    expect(find.text('today'), findsOneWidget);
  });

  for (final width in [375.0, 640.0]) {
    testWidgets('date cells fit a $width-wide calendar and resize',
        (tester) async {
      tester.view.physicalSize = const Size(1440, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final controller = TWCalendarController(
        firstDate: DateTime(2025, 4),
        lastDate: DateTime(2025, 4, 30),
      );
      final calendar = TWCalendarList(
        calendarController: controller,
        configs: TWCalendarConfigs(
          monthViewConfig: TWCalendarMonthViewConfig(padding: 24),
        ),
      );

      Future<void> pumpCalendar(double width) async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(width: width, child: calendar),
            ),
          ),
        ));
      }

      await pumpCalendar(width);
      expect(tester.takeException(), isNull);
      expect(tester.widget<TWDayNumber>(find.byType(TWDayNumber).first).size,
          closeTo((width - 48) / 7, 0.001));

      await pumpCalendar(420);
      expect(tester.takeException(), isNull);
      expect(tester.widget<TWDayNumber>(find.byType(TWDayNumber).first).size,
          closeTo((420 - 48) / 7, 0.001));
    });
  }

  testWidgets('custom date widgets use local width and remain selectable',
      (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    DateTime? selectedDate;
    final controller = TWCalendarController(
      firstDate: DateTime(2025, 4),
      lastDate: DateTime(2025, 4, 30),
      onSelectDayRang: (date, _) => selectedDate = date,
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 640,
            child: TWCalendarList(
              calendarController: controller,
              configs: TWCalendarConfigs(
                dayNumberConfig: TWCalendarDayNumberConfig(
                  widgetHandler: (year, month, day, size, isSelected, isToday,
                      canSelected, isMin, isMax) {
                    return SizedBox(
                      key: ValueKey('day-$day'),
                      width: size,
                      height: size,
                      child: Text('$day'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    ));
    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byKey(const ValueKey('day-1'))).width,
        closeTo((640 - 16) / 7, 0.001));
    await tester.tap(find.byKey(const ValueKey('day-3')));
    await tester.pump();
    expect(selectedDate, DateTime(2025, 4, 3));
    expect(tester.takeException(), isNull);
  });
}
