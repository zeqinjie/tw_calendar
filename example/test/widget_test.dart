import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tw_calendar/tw_calendar.dart';
import 'package:tw_calendar_example/main.dart';

void main() {
  for (final size in [const Size(1440, 1000), const Size(375, 800)]) {
    testWidgets('all calendar examples fit a ${size.width}-wide window',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Calendar Demo'), findsOneWidget);

      for (final label in [
        'Calendar: Multiple Serial Date Selected',
        'Calendar: Custom Header Widget',
        'Calendar: Multiple NotSerial Date Selected',
        'Calendar: Custom Date Widget',
        'Calendar: Limit Max or Min Selected Days',
      ]) {
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
        expect(find.byType(TWCalendarList), findsOneWidget);
        expect(tester.takeException(), isNull, reason: label);
        final calendar = tester.getRect(find.byType(TWCalendarList));
        expect(calendar.top, greaterThanOrEqualTo(0), reason: label);
        expect(calendar.bottom, lessThanOrEqualTo(size.height), reason: label);
        if (label == 'Calendar: Multiple Serial Date Selected') {
          final title = tester.widget<Text>(find.text('Calendar Widget'));
          expect(title.style!.fontSize, lessThanOrEqualTo(24));
        }
        Navigator.of(tester.element(find.byType(TWCalendarList))).pop();
        await tester.pumpAndSettle();
      }
    });
  }
}
