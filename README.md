# tw_calendar

This is a simple calendar widget.

## introduce

![](https://github.com/zeqinjie/tw_calendar/blob/main/assets/1.gif)

![](https://github.com/zeqinjie/tw_calendar/blob/main/assets/2.gif)

## Installing

Add tw_calendar to your pubspec.yaml file:

```yaml
dependencies:
  tw_calendar: latest_version
```

import tw_calendar in files that it will be used:
```dart
import 'package:tw_calendar/tw_calendar.dart';
```

## Getting Started
some support property 

```dart
/// 开始的年月份
  final DateTime firstDate;

  /// 结束的年月份
  final DateTime lastDate;

  /// 选择开始日期
  final DateTime? selectedStartDate;

  /// 选择结束日期
  final DateTime? selectedEndDate;

  /// 点击方法回调
  final Function? onSelectFinish;

  /// 头部组件
  final Widget? headerView;

  /// 选择模式
  final TWCalendarListSeletedMode? seletedMode;

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

  /// 点击回调
  final void Function(DateTime seletedDate, int seletedDays)? onSelectDayRang;

  /// 选择 title 回调
  final String Function(
          DateTime? selectStartTime, DateTime? selectEndTime, int seletedDays)?
      onSelectDayTitle;
```
example

```dart
TWCalendarList(
      firstDate: TWCalendarTool.tomorrow,
      lastDate: DateTime(2022, 11, 21),
      selectedStartDate: DateTime(2022, 9, 2),
      selectedEndDate: DateTime(2022, 9, 10),
      monthBodyHeight: 300.w,
      seletedMode: TWCalendarListSeletedMode.singleSerial,
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          '日历组件',
          style: TextStyle(
            color: TWColors.tw333333,
            fontSize: 18.w,
          ),
        ),
      ),
      onSelectDayRang: ((seletedDate, seletedDays) {
        print('seletedDate : $seletedDate, seletedDays : $seletedDays');
      }),
      onSelectFinish: (selectStartTime, selectEndTime) {
        print(
            'selectStartTime : $selectStartTime, selectEndTime : $selectEndTime');
        Navigator.pop(context);
      },
    )
```

## thx
thank you ,and modify form this demo. [flutter_calendar_list](https://github.com/heruijun/flutter_calendar_list)
