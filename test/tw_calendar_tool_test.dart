import 'package:flutter_test/flutter_test.dart';
import 'package:tw_calendar/tw_calendar.dart';

void main() {
  group('month lengths', () {
    final cases = {
      DateTime(2024, 2): 29,
      DateTime(2025, 2): 28,
      DateTime(1900, 2): 28,
      DateTime(2000, 2): 29,
      DateTime(2025, 4): 30,
      DateTime(2025, 12): 31,
    };

    for (final entry in cases.entries) {
      test('${entry.key.year}/${entry.key.month} has ${entry.value} days', () {
        expect(TWCalendarTool.getDaysInMonth(entry.key.year, entry.key.month),
            entry.value);
      });
    }
  });

  group('date normalization', () {
    test('onlyDay removes hours, minutes, seconds and subsecond precision', () {
      expect(
        TWCalendarTool.onlyDay(DateTime(2025, 4, 3, 23, 59, 58, 123, 456)),
        DateTime(2025, 4, 3),
      );
    });

    test('onlyDay preserves an absent selection', () {
      expect(TWCalendarTool.onlyDay(null), isNull);
    });

    test('isSameDate ignores time within the same calendar day', () {
      expect(
        TWCalendarTool.isSameDate(
            DateTime(2025, 4, 3), DateTime(2025, 4, 3, 23, 59)),
        isTrue,
      );
    });

    test('isSameDate distinguishes the year, month and day', () {
      final date = DateTime(2025, 4, 3);
      for (final other in [
        DateTime(2024, 4, 3),
        DateTime(2025, 5, 3),
        DateTime(2025, 4, 4),
      ]) {
        expect(TWCalendarTool.isSameDate(date, other), isFalse);
      }
    });
  });

  group('selectable date range', () {
    final first = DateTime(2025, 4, 3);
    final last = DateTime(2025, 4, 5);

    test('includes both boundaries and the dates between them', () {
      for (final day in [3, 4, 5]) {
        expect(
            TWCalendarTool.dateIsBetweenIn(DateTime(2025, 4, day), first, last),
            isTrue);
      }
    });

    test('excludes dates before and after the range', () {
      for (final day in [2, 6]) {
        expect(
            TWCalendarTool.dateIsBetweenIn(DateTime(2025, 4, day), first, last),
            isFalse);
      }
    });

    test('allows a range consisting of a single date', () {
      expect(TWCalendarTool.dateIsBetweenIn(first, first, first), isTrue);
    });
  });

  group('selected day count', () {
    test('returns zero when there is no selection', () {
      expect(TWCalendarTool.getSelectedDays(null, null), 0);
    });

    test('counts a start date without an end as one day', () {
      expect(TWCalendarTool.getSelectedDays(DateTime(2025, 4, 3), null), 1);
    });

    test('counts the same day once regardless of the time', () {
      expect(
        TWCalendarTool.getSelectedDays(
            DateTime(2025, 4, 3, 23, 59), DateTime(2025, 4, 3, 1)),
        1,
      );
    });

    test('includes both endpoints across a leap day', () {
      expect(
        TWCalendarTool.getSelectedDays(
            DateTime(2024, 2, 28, 23), DateTime(2024, 3, 1, 1)),
        3,
      );
    });

    test('counts dates across a year boundary', () {
      expect(
        TWCalendarTool.getSelectedDays(
            DateTime(2024, 12, 31), DateTime(2025, 1, 2)),
        3,
      );
    });
  });

  group('selection titles', () {
    test('returns no title for an absent selection', () {
      expect(TWCalendarTool.getSelectedDaysTitle(null, null), isNull);
    });

    test('formats a single date with leading zeros', () {
      expect(TWCalendarTool.getSelectedDaysTitle(DateTime(2025, 4, 3), null),
          '04.03');
    });

    test('formats both endpoints across a year boundary', () {
      expect(
        TWCalendarTool.getSelectedDaysTitle(
            DateTime(2024, 12, 31), DateTime(2025, 1, 2)),
        '12.31-01.02',
      );
    });
  });

  group('non-consecutive selections', () {
    test('finds a selected day regardless of time and rejects missing days',
        () {
      final dates = [DateTime(2025, 4, 3, 18), DateTime(2025, 4, 5)];
      expect(
        TWCalendarTool.isHadSelected(
            selectedTimes: dates, dateTime: DateTime(2025, 4, 3)),
        isTrue,
      );
      expect(
        TWCalendarTool.isHadSelected(
            selectedTimes: dates, dateTime: DateTime(2025, 5, 3)),
        isFalse,
      );
      expect(
        TWCalendarTool.isHadSelected(
            selectedTimes: [], dateTime: DateTime(2025, 4, 3)),
        isFalse,
      );
    });

    test('removes every occurrence of the day without removing other days', () {
      final dates = [
        DateTime(2025, 4, 3),
        DateTime(2025, 4, 3, 18),
        DateTime(2025, 4, 5),
        DateTime(2025, 5, 3),
      ];
      TWCalendarTool.removeSelected(
          selectedTimes: dates, dateTime: DateTime(2025, 4, 3, 12));
      expect(dates, [DateTime(2025, 4, 5), DateTime(2025, 5, 3)]);
    });

    test('sorts the original selection list chronologically across years', () {
      final dates = [
        DateTime(2025, 1, 3),
        DateTime(2024, 12, 31),
        DateTime(2025, 1, 1),
      ];
      TWCalendarTool.sortDateTimes(dates);
      expect(dates, [
        DateTime(2024, 12, 31),
        DateTime(2025, 1, 1),
        DateTime(2025, 1, 3),
      ]);
    });
  });
}
