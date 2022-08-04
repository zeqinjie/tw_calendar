/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-08-04 16:51:36
 * @Description: 天数
 */
import 'package:flutter/material.dart';
import 'tw_calendar_notification.dart';
import 'utils/tw_calendart_tool.dart';
import 'utils/tw_colors.dart';

class TWDayNumber extends StatefulWidget {
  const TWDayNumber({
    Key? key,
    required this.size,
    required this.day,
    required this.isDefaultSelected,
    this.isToday = false,
    this.canSelected = true,
    this.todayColor,
    this.itemMargin,
    this.fontSize,
    this.todayFontSize,
  }) : super(key: key);

  final int day;
  final bool isToday;
  final Color? todayColor;
  final double size;
  final bool isDefaultSelected;
  final bool canSelected;
  final double? itemMargin;
  final double? fontSize;
  final double? todayFontSize;
  @override
  _TWDayNumberState createState() => _TWDayNumberState();
}

class _TWDayNumberState extends State<TWDayNumber> {
  bool isSelected = false;

  Widget _dayItem() {
    final double itemMargin = widget.itemMargin ?? 5;
    return Container(
      width: widget.size - itemMargin * 2,
      height: widget.size - itemMargin * 2,
      margin: EdgeInsets.all(itemMargin),
      alignment: Alignment.center,
      decoration: (isSelected && widget.day > 0)
          ? BoxDecoration(
              color: TWColors.twFF8000,
              borderRadius: BorderRadius.circular(4),
            )
          : (widget.isToday && widget.day > 0)
              ? BoxDecoration(
                  color: widget.todayColor,
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDay(),
          if (widget.isToday && widget.day > 0) _buildToDay(),
        ],
      ),
    );
  }

  Text _buildDay() {
    Color color = TWColors.tw666666;
    if (!widget.canSelected) {
      color = TWColors.twCCCCCC;
    }
    if (widget.isToday || isSelected) {
      color = TWColors.twFFFFFF;
    }
    return Text(
      widget.day < 1 ? '' : TWCalendarTool.formatPadLeft(widget.day),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: widget.fontSize ?? 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildToDay() {
    return Text(
      '今天',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: TWColors.twFFFFFF,
        fontSize: widget.todayFontSize ?? 10,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isDefaultSelected;
    return widget.day > 0
        ? InkWell(
            onTap: () {
              if (widget.canSelected) {
                TWCalendarNotification(widget.day).dispatch(context);
              }
            },
            child: _dayItem())
        : _dayItem();
  }
}
