/*
 * @Author: zhengzeqin
 * @Date: 2022-08-28 15:21:50
 * @LastEditTime: 2022-08-28 22:57:22
 * @Description: your project
 * 
 */
import 'package:flutter/material.dart';

class TWCalendarConfigs {
  /// 日历列表配置对象
  final TWCalendarListConfig? listConfig;

  /// 日历周视图配置对象
  final TWCalendarWeekViewConfig? weekViewConfig;

  /// 月历配置对象
  final TWCalendarMonthViewConfig? monthViewConfig;

  TWCalendarConfigs({
    this.monthViewConfig,
    this.listConfig,
    this.weekViewConfig,
  });
}

/* 列表部分 */
class TWCalendarListConfig {
  /// 水平间隙，默认 8
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
    this.horizontalSpace,
    this.ensureViewHeight,
    this.ensureViewPadding,
    this.ensureViewSelectedColor,
    this.ensureViewUnSelectedColor,
    this.dayNumberTodayColor,
    this.dayNumberSelectedColor,
    this.ensureTitleFontSize,
  });
}

/* 月历视图部分 */
class TWCalendarMonthViewConfig {
  /// 月视图高度，为空则占满剩余空间
  final double? monthBodyHeight;

  TWCalendarMonthViewConfig({
    this.monthBodyHeight,
  });
}

/* 周视图部分 */
class TWCalendarWeekViewConfig {
  /// 周视图高度， 默认 48
  final double? weekDayHeight;

  TWCalendarWeekViewConfig({
    this.weekDayHeight,
  });
}
