/*
 * @Author: zhengzeqin
 * @Date: 2022-07-21 17:26:09
 * @LastEditTime: 2022-10-04 12:30:16
 * @Description: 月视图
 */

import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_day_number.dart';
import 'tw_calendar_cofigs.dart';
import 'tw_calendar_notification.dart';
import 'tw_month_title.dart';
import 'utils/tw_calendart_tool.dart';

class TWMonthView extends StatefulWidget {
  final BuildContext context;
  final int year;
  final int month;
  final DateTime? selectStartDateTime;
  final DateTime? selectEndDateTime;
  final List<DateTime>? notSerialSelectedTimes;

  /// 配置样式对象
  final TWCalendarConfigs? configs;

  const TWMonthView({
    Key? key,
    this.notSerialSelectedTimes,
    this.selectStartDateTime,
    this.selectEndDateTime,
    required this.context,
    required this.year,
    required this.month,
    required this.onSelectDayRang,
    required this.firstDate,
    required this.lastDate,
    required this.configs,
  }) : super(key: key);

  /// 开始的年月份
  final DateTime firstDate;

  /// 结束的年月份
  final DateTime lastDate;

  final void Function(DateTime seletedDate) onSelectDayRang;

  double get itemWidth => TWCalendarTool.getDayNumberSize(
      context, configs?.monthViewConfig?.padding ?? 8);

  @override
  TWMonthViewState createState() => TWMonthViewState();
}

class TWMonthViewState extends State<TWMonthView> {
  DateTime? selectedDate;
  late double padding;

  @override
  void initState() {
    super.initState();
    padding = widget.configs?.monthViewConfig?.padding ?? 8;
  }

  @override
  Widget build(BuildContext context) {
    return buildMonthView(context);
  }

  Widget buildMonthDays(BuildContext context) {
    List<Row> dayRows = <Row>[];
    List<Widget> dayRowChildren = <Widget>[];

    int daysInMonth = TWCalendarTool.getDaysInMonth(
      widget.year,
      widget.month,
    );

    // 日 一 二 三 四 五 六
    int firstWeekdayOfMonth = DateTime(widget.year, widget.month, 2).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      DateTime moment = DateTime(widget.year, widget.month, day);
      final bool isToday = TWCalendarTool.dateIsToday(moment);
      final canSelected = canSelectedDate(date: moment, isToday: isToday);
      bool isSelected = false;
      // 连续选择
      if (widget.notSerialSelectedTimes != null &&
          widget.notSerialSelectedTimes!.isNotEmpty) {
        isSelected = TWCalendarTool.isHadSeletced(
            selectedTimes: widget.notSerialSelectedTimes!, dateTime: moment);
      } else {
        if (widget.selectStartDateTime == null &&
            widget.selectEndDateTime == null &&
            selectedDate == null) {
          isSelected = false;
        }
        if (widget.selectStartDateTime == selectedDate &&
            widget.selectEndDateTime == null &&
            selectedDate?.day == day &&
            day > 0) {
          isSelected = true;
        }
        if (widget.selectStartDateTime != null &&
            widget.selectEndDateTime != null) {
          isSelected =
              (TWCalendarTool.isSameDate(moment, widget.selectStartDateTime!) ||
                          TWCalendarTool.isSameDate(
                              moment, widget.selectEndDateTime!)) ||
                      moment.isAfter(widget.selectStartDateTime!) &&
                          moment.isBefore(widget.selectEndDateTime!) &&
                          day > 0
                  ? true
                  : false;
        }
      }
      Widget? widgetHandler;
      if (widget.configs?.dayNumberConfig?.widgetHandler != null) {
        if (day > 0) {
          widgetHandler = widget.configs?.dayNumberConfig?.widgetHandler!(
            widget.year,
            widget.month,
            day,
            widget.itemWidth,
            isSelected,
            isToday,
            canSelected,
          );
          if (widgetHandler != null) {
            widgetHandler = TWTapNotificationView(
              canSelected: canSelected,
              day: day,
              child: widgetHandler,
            );
          }
        }
      }
      widgetHandler ??= TWDayNumber(
        size: widget.itemWidth,
        isSelected: isSelected,
        isToday: isToday,
        canSelected: canSelected,
        day: day,
        dayNumberConfig: widget.configs?.dayNumberConfig,
      );
      dayRowChildren.add(widgetHandler);

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<Widget>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return NotificationListener<TWCalendarNotification>(
      onNotification: (notification) {
        selectedDate = DateTime(
          widget.year,
          widget.month,
          notification.selectDay,
        );
        if (selectedDate != null) {
          widget.onSelectDayRang(selectedDate!);
        }

        return true;
      },
      child: Container(
        width: 7 * TWCalendarTool.getDayNumberSize(context, padding),
        margin: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TWMonthTitle(
              year: widget.year,
              month: widget.month,
              monthViewConfig: widget.configs?.monthViewConfig,
            ),
            SizedBox(
              height: padding,
            ),
            buildMonthDays(context),
          ],
        ),
      ),
    );
  }

  /* Priavte Method */
  bool canSelectedDate({
    required DateTime date,
    required bool isToday,
  }) {
    final canSelectedToday =
        widget.configs?.monthViewConfig?.canSelectedToday ?? false;
    if (!canSelectedToday) {
      if (isToday) {
        // 当天不可以选择
        return false;
      }
    }
    return TWCalendarTool.dateIsBetweenIn(
      date,
      widget.firstDate,
      widget.lastDate,
    );
  }
}
