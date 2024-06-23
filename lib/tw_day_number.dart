/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-10-04 12:29:50
 * @Description: 天数
 */

import 'package:flutter/material.dart';
import 'tw_calendar_configs.dart';
import 'tw_calendar_notification.dart';
import 'utils/tw_calendar_tool.dart';

class TWDayNumber extends StatefulWidget {
  final int day;
  final bool isToday;
  final double size;
  final bool isSelected;
  final bool canSelected;
  final bool isMaxSelectedDays;
  final bool isMinSelectedDays;
  final TWCalendarDayNumberConfig? dayNumberConfig;

  const TWDayNumber({
    Key? key,
    required this.size,
    required this.day,
    required this.isSelected,
    required this.dayNumberConfig,
    required this.isMaxSelectedDays,
    required this.isMinSelectedDays,
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
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDay(),
          if (widget.isToday && widget.day > 0) _buildToDay(),
        ],
      ),
    );
  }

  /// 获取背景颜色
  Color? _getBackgroundColor() {
    Color? backgroundColor;
    if (isSelected && widget.day > 0) {
      if (widget.isMaxSelectedDays || widget.isMinSelectedDays) {
        backgroundColor =
            widget.dayNumberConfig?.minOrMaxSelectedBackgroundColor ??
                const Color(0XFFF5F5F5);
      } else {
        backgroundColor = widget.dayNumberConfig?.selectedBackgroundColor ??
            const Color(0XFFFF8000);
      }
    } else if (widget.isToday && widget.day > 0) {
      backgroundColor = widget.dayNumberConfig?.todayBackgroundColor ??
          const Color(0XFFB3B3B3);
    }
    return backgroundColor;
  }

  /// 获取字体颜色
  Color? _getDayTitleColor() {
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
      if (widget.isMaxSelectedDays || widget.isMinSelectedDays) {
        color = widget.dayNumberConfig?.minOrMaxSelectedTitleColor ??
            const Color(0XFFCCCCCC);
      } else {
        color = widget.dayNumberConfig?.selectedTitleColor ?? Colors.white;
      }
    }
    return color;
  }

  /// 获取今天字体颜色
  Color? _getToDayTitleColor() {
    Color? color = widget.dayNumberConfig?.todayTitleColor ?? Colors.white;
    if (isSelected) {
      if (widget.isMaxSelectedDays || widget.isMinSelectedDays) {
        color = widget.dayNumberConfig?.minOrMaxSelectedTitleColor ??
            const Color(0XFFCCCCCC);
      }
    }
    return color;
  }

  Text _buildDay() {
    return Text(
      widget.day < 1 ? '' : TWCalendarTool.formatPadLeft(widget.day),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: _getDayTitleColor(),
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
        color: _getToDayTitleColor(),
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
