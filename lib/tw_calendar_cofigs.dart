/*
 * @Author: zhengzeqin
 * @Date: 2022-08-28 15:21:50
 * @LastEditTime: 2022-08-28 16:00:59
 * @Description: your project
 * 
 */
import 'package:flutter/material.dart';

class TWCalendarConfigs {
  ///  月历配置对象
  final TWCalendarMonthViewConfig? monthViewConfig;

  ///  日历列表配置对象
  final TWCalendarListConfig? listConfig;

  TWCalendarConfigs({
    this.monthViewConfig,
    this.listConfig,
  });
}

/* 列表部分 */
class TWCalendarListConfig {
  /// 月视图高度，为空则占满剩余空间
  final double? monthBodyHeight;

  /// 周视图高度， 默认 48
  final double? weekDayHeight;

  /// 水平间隙
  final double? horizontalSpace;

  /// 确认周视图高度， 默认 66
  final double? ensureViewHeight;

  /// 确认按钮的间隙
  final EdgeInsetsGeometry? ensureViewPadding;

  /// 确认按钮选中颜色
  final Color? ensureViewSelectedColor;

  /// 确认未按钮选中颜色
  final Color? ensureViewUnSelectedColor;

  /// 今天的日期的背景颜色
  final Color? dayNumberTodayColor;

  /// 选中日期背景颜色
  final Color? dayNumberSelectedColor;

  /// 确认按钮字体大小
  final double? ensureTitleFontSize;

  TWCalendarListConfig({
    this.monthBodyHeight,
    this.weekDayHeight,
    this.horizontalSpace,
    this.ensureViewHeight,
    this.ensureViewPadding,
    this.ensureViewSelectedColor = const Color(0XFFFF8000),
    this.ensureViewUnSelectedColor = const Color(0XFFB3B3B3),
    this.dayNumberTodayColor,
    this.dayNumberSelectedColor,
    this.ensureTitleFontSize,
  });
}

/* 月历视图部分 */
class TWCalendarMonthViewConfig {}

/* 周视图部分 */
class TWCalendarWeekViewConfig {}
