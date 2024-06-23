/*
 * @Author: zhengzeqin
 * @Date: 2022-08-28 15:21:50
 * @LastEditTime: 2022-10-04 12:51:35
 * @Description: your project
 * 
 */
import 'package:flutter/material.dart';

/// 选择模式
enum TWCalendarListSelectedMode {
  /// 默认: 单选连续,从可选日开始
  singleSerial,

  /// 默认选择是连续多选
  doubleSerial,

  /// 多选非连续
  notSerial,
}

class TWCalendarConfigs {
  /// 日历列表配置对象
  final TWCalendarListConfig? listConfig;

  /// 月历配置对象
  final TWCalendarMonthViewConfig? monthViewConfig;

  /// 日期配置对象
  final TWCalendarDayNumberConfig? dayNumberConfig;

  /// 周视图配置对象
  final TWCalendarWeekdayRowConfig? weekdayRowConfig;

  TWCalendarConfigs({
    this.listConfig,
    this.monthViewConfig,
    this.dayNumberConfig,
    this.weekdayRowConfig,
  });
}

/* 列表部分 */
class TWCalendarListConfig {
  /// 选择模式
  final TWCalendarListSelectedMode? selectedMode;

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

  /// 确认按钮字体颜色
  final Color? ensureTitleColor;

  /// 确定按钮 decoration
  final Decoration? ensureViewDecoration;

  /// 最小选择天数
  final int? minSelectDays;

  /// 最大选择天数
  final int? maxSelectDays;

  TWCalendarListConfig({
    this.ensureTitleColor,
    this.selectedMode,
    this.horizontalSpace,
    this.ensureViewHeight,
    this.ensureViewPadding,
    this.ensureViewSelectedColor,
    this.ensureViewUnSelectedColor,
    this.ensureTitleFontSize,
    this.ensureViewDecoration,
    this.minSelectDays,
    this.maxSelectDays,
  });
}

/* 月历视图部分 */
class TWCalendarMonthViewConfig {
  /// 月历标题排序， 默认从周日开始，如是周一开始则偏移量是 1
  final int? sortOffset;

  /// 月视图高度，为空则占满剩余空间
  final double? monthBodyHeight;

  /// 今天是否可以选择, 默认不支持
  final bool? canSelectedToday;

  /// 月份标题
  final List<String>? monthNames;

  /// 年标题
  final String? yearTitle;

  /// 年月标题字体大小
  final double? titleFontSize;

  /// 间隙, 默认 8
  final double? padding;

  /// 月历 title 回调
  final String Function(int year, int month)? titleHandler;

  /// 月份配置对象
  TWCalendarMonthViewConfig({
    this.padding,
    this.monthBodyHeight,
    this.canSelectedToday,
    this.monthNames,
    this.yearTitle,
    this.titleFontSize,
    this.sortOffset,
    this.titleHandler,
  });
}

class TWCalendarDayNumberConfig {
  /// 今天颜色
  final Color? todayBackgroundColor;

  /// 今天颜色
  final Color? todayTitleColor;

  /// 未符合最小或最大选择天数背景颜色
  final Color? minOrMaxSelectedBackgroundColor;

  /// 未符合最小或最大选择天数标题颜色
  final Color? minOrMaxSelectedTitleColor;

  /// 选择背景颜色
  final Color? selectedBackgroundColor;

  /// 选择颜色
  final Color? selectedTitleColor;

  /// 选择颜色
  final Color? unSelectedTitleColor;

  /// 禁止选择颜色
  final Color? forbidSelectedTitleColor;

  /// 间隙
  final double? itemMargin;

  /// 字体大小
  final double? fontSize;

  /// 今天字体大小
  final double? todayFontSize;

  /// 今天标识
  final String? todyTitle;

  /// 自定义 widget
  final Widget? Function(
    int year,
    int month,
    int day,
    double size,
    bool isSelected,
    bool isToday,
    bool canSelected,
    bool isMinSelectedDays,
    bool isMaxSelectedDays,
  )? widgetHandler;

  TWCalendarDayNumberConfig({
    this.widgetHandler,
    this.todayBackgroundColor,
    this.minOrMaxSelectedBackgroundColor,
    this.minOrMaxSelectedTitleColor,
    this.todayTitleColor,
    this.selectedBackgroundColor,
    this.selectedTitleColor,
    this.unSelectedTitleColor,
    this.forbidSelectedTitleColor,
    this.itemMargin,
    this.fontSize,
    this.todyTitle,
    this.todayFontSize,
  });
}

class TWCalendarWeekdayRowConfig {
  /// 周视图高度， 默认 48
  final double? weekDayHeight;

  /// 标题颜色
  final Color? titleColor;

  /// 标题字体大小
  final double? titleFontSize;

  /// 周视图 titles
  final List<String>? titles;
  TWCalendarWeekdayRowConfig({
    this.weekDayHeight,
    this.titleColor,
    this.titleFontSize,
    this.titles,
  });
}
