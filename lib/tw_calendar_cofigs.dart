/*
 * @Author: zhengzeqin
 * @Date: 2022-08-28 15:21:50
 * @LastEditTime: 2022-09-03 22:36:01
 * @Description: your project
 * 
 */
import 'package:flutter/material.dart';

enum TWCalendarListSeletedMode {
  /// 默认: 单选连续,从可选日开始
  singleSerial,

  /// 默认选择是连续多选
  doubleSerial,
}

class TWCalendarConfigs {
  /// 日历列表配置对象
  final TWCalendarListConfig? listConfig;

  /// 日历周视图配置对象
  final TWCalendarWeekViewConfig? weekViewConfig;

  /// 月历配置对象
  final TWCalendarMonthViewConfig? monthViewConfig;

  /// 月历配置对象
  final TWCalendarDayNumberConfig? dayNumberConfig;

  TWCalendarConfigs({
    this.listConfig,
    this.monthViewConfig,
    this.weekViewConfig,
    this.dayNumberConfig,
  });
}

/* 列表部分 */
class TWCalendarListConfig {
  /// 选择模式
  final TWCalendarListSeletedMode? seletedMode;

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

  /// 确认按钮字体大小
  final double? ensureTitleFontSize;

  TWCalendarListConfig({
    this.seletedMode,
    this.horizontalSpace,
    this.ensureViewHeight,
    this.ensureViewPadding,
    this.ensureViewSelectedColor,
    this.ensureViewUnSelectedColor,
    this.ensureTitleFontSize,
  });
}

/* 月历视图部分 */
class TWCalendarMonthViewConfig {
  /// 月视图高度，为空则占满剩余空间
  final double? monthBodyHeight;

  /// 今天是否可以选择, 默认不支持
  final bool? canSelectedToday;

  /// 月份标题
  final List<String>? monthNames;

  /// 间隙, 默认 8
  final double? padding;

  TWCalendarMonthViewConfig({
    this.padding,
    this.monthBodyHeight,
    this.canSelectedToday,
    this.monthNames,
  });
}

class TWCalendarDayNumberConfig {
  /// 今天颜色
  final Color? todayColor;

  /// 选择颜色
  final Color? selectedColor;

  /// 选择颜色
  final Color? unSelectedColor;

  /// 间隙
  final double? itemMargin;

  /// 字体大小
  final double? fontSize;

  /// 今天字体大小
  final double? todayFontSize;

  TWCalendarDayNumberConfig({
    this.todayColor,
    this.selectedColor,
    this.unSelectedColor,
    this.itemMargin,
    this.fontSize,
    this.todayFontSize,
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
