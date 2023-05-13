/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-10-04 12:29:50
 * @Description: 天数
 */
import 'package:flutter/material.dart';
import 'tw_calendar_cofigs.dart';
import 'tw_calendar_notification.dart';
import 'utils/tw_calendart_tool.dart';

class TWDayNumber extends StatefulWidget {
  final int day;
  final bool isToday;
  final double size;
  final bool isSelected;
  final bool canSelected;

  final TWCalendarDayNumberConfig? dayNumberConfig;

  const TWDayNumber({
    Key? key,
    required this.size,
    required this.day,
    required this.isSelected,
    required this.dayNumberConfig,
    this.isToday = false,
    this.canSelected = true,
  }) : super(key: key);

  @override
  TWDayNumberState createState() => TWDayNumberState();
}

class TWDayNumberState extends State<TWDayNumber> {
  bool isSelected = false;

  Widget _dayItem() {
    final double itemMargin = widget.dayNumberConfig?.itemMargin ?? 5;
    return Container(
      width: widget.size - itemMargin * 2,
      height: widget.size - itemMargin * 2,
      margin: EdgeInsets.all(itemMargin),
      alignment: Alignment.center,
      decoration: (isSelected && widget.day > 0)
          ? BoxDecoration(
              color: widget.dayNumberConfig?.selectedBackgroundColor ??
                  const Color(0XFFFF8000),
              borderRadius: BorderRadius.circular(4),
            )
          : (widget.isToday && widget.day > 0)
              ? BoxDecoration(
                  color: widget.dayNumberConfig?.todayBackgroundColor ??
                      const Color(0XFFB3B3B3),
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
    Color color =
        widget.dayNumberConfig?.unSelectedTitleColor ?? const Color(0XFF666666);
    if (!widget.canSelected) {
      color = widget.dayNumberConfig?.forbidSelectedTitleColor ??
          const Color(0XFFCCCCCC);
    }
    if (widget.isToday) {
      color = widget.dayNumberConfig?.todayTitleColor ?? Colors.white;
    }
    if (isSelected) {
      color = widget.dayNumberConfig?.selectedTitleColor ?? Colors.white;
    }

    return Text(
      widget.day < 1 ? '' : TWCalendarTool.formatPadLeft(widget.day),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: widget.dayNumberConfig?.fontSize ?? 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildToDay() {
    return Text(
      widget.dayNumberConfig?.todyTitle ?? '今天',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: widget.dayNumberConfig?.todayTitleColor ?? Colors.white,
        fontSize: widget.dayNumberConfig?.todayFontSize ?? 10,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isSelected && widget.canSelected;
    return widget.day > 0
        ? TWTapNotificationView(
            canSelected: widget.canSelected,
            day: widget.day,
            child: _dayItem(),
          )
        : _dayItem();
  }
}

class TWTapNotificationView extends StatelessWidget {
  final bool canSelected;
  final int day;
  final Widget child;
  const TWTapNotificationView({
    Key? key,
    required this.canSelected,
    required this.day,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (canSelected) {
          TWCalendarNotification(day).dispatch(context);
        }
      },
      child: child,
    );
  }
}
