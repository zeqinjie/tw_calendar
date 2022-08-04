/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-08-04 15:28:27
 * @Description: 日历辅助工具类
 */

import 'package:flutter/material.dart';

class TWCalendarTool {
  static double getDayNumberSize(BuildContext context, double padding) {
    return (MediaQuery.of(context).size.width - padding * 2) / 7;
  }

  static bool dateIsToday(DateTime date) {
    final DateTime now = DateTime.now();
    return isSameDate(date, now);
  }

  static DateTime get today {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime get tomorrow {
    return today.add(const Duration(days: 1));
  }

  /// 在过去和未来直接
  static bool dateIsBetweenIn(
      DateTime date, DateTime firstDate, DateTime lastDate) {
    final r1 = date.compareTo(firstDate);
    final r2 = date.compareTo(lastDate);
    if ((r1 == 1 || r1 == 0) && (r2 == -1 || r2 == 0)) {
      return true;
    }
    return false;
  }

  static bool isSameDate(DateTime firstDate, DateTime secondDate) {
    return firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month &&
        firstDate.day == secondDate.day;
  }

  static int getDaysInMonth(int year, int month) {
    return month < DateTime.monthsPerYear
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;
  }

  static String getMonthName(
    int month, {
    List<String>? monthNames,
  }) {
    final List<String> names = monthNames ??
        <String>[
          '01月',
          '02月',
          '03月',
          '04月',
          '05月',
          '06月',
          '07月',
          '08月',
          '09月',
          '10月',
          '11月',
          '12月',
        ];
    return names[month - 1];
  }

  static String getYearName(
    int year,
  ) {
    return '$year年';
  }

  /// 选择标题
  static String? getSelectedDaysTitle(
    DateTime? selectStartTime,
    DateTime? selectEndTime,
  ) {
    if (selectStartTime != null && selectEndTime != null) {
      return '${formatPadLeft(selectStartTime.month)}.${formatPadLeft(selectStartTime.day)}-${formatPadLeft(selectEndTime.month)}.${formatPadLeft(selectEndTime.day)}';
    }
    if (selectStartTime != null && selectEndTime == null) {
      return '${formatPadLeft(selectStartTime.month)}.${formatPadLeft(selectStartTime.day)}';
    }
    return null;
  }

  static String formatPadLeft(int number, {int count = 2}) {
    return number.toString().padLeft(count, '0');
  }

  /// 选择天数
  static int getSelectedDays(
    DateTime? selectStartTime,
    DateTime? selectEndTime,
  ) {
    if (selectStartTime != null && selectEndTime != null) {
      final start = DateTime(
          selectStartTime.year, selectStartTime.month, selectStartTime.day);
      final end =
          DateTime(selectEndTime.year, selectEndTime.month, selectEndTime.day);
      final d = end.difference(start);
      return d.inDays + 1;
    }
    if (selectStartTime != null) {
      return 1;
    }
    return 0;
  }
}
