# tw_calendar

This is a simple step calendar widget.

## introduce

![](https://github.com/zeqinjie/tw_calendar/blob/main/assets/1.png)

![](https://github.com/zeqinjie/tw_calendar/blob/main/assets/2.png)


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

/// 月视图高度
final double? monthBodyHeight;

/// 周视图高度
final double? weekDayHeight;

/// 水平间隙
final double? horizontalSpace;

/// 确认按钮高度
final double? ensureViewHeight;

/// 确认按钮 padding
final EdgeInsetsGeometry? ensureViewPadding;

/// 确认按钮选择颜色
final Color? ensureViewSelectedColor;

/// 确认按钮未选择颜色
final Color? ensureViewUnSelectedColor;

/// 确认 title 颜色
final double? ensureTitleFontSize;
```
example

```dart
TWCalendarList(
      firstDate: DateTime(2022, 7, 21),
      lastDate: DateTime(2022, 9, 21),
      selectedStartDate: DateTime(2022, 8, 28),
      selectedEndDate: DateTime(2022, 9, 2),
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

