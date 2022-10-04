# tw_calendar

This is a simple calendar widget.

- pub: [tw_calendar](https://pub.flutter-io.cn/packages/tw_calendar)
- juejin: [a simple calendar widget](https://zhengzeqin.netlify.app/2022/08/04/%E4%B8%80%E4%B8%AA%E7%AE%80%E5%8D%95%E7%9A%84-flutter-%E6%97%A5%E5%8E%86%E7%BB%84%E4%BB%B6/)

## introduce

![](https://github.com/zeqinjie/tw_calendar/blob/main/assets/1.gif)

## version
- 1.2.0
  - support custom date widget
- 1.1.0
  - support not serial multiple selection
  - fix bug
- 1.0.2
  - add export class
- 1.0.1
  - remove unnecessary dependencies libraries
- 1.0.0
  - support change to modify style cofigures
- 0.1.3
  - fix bug
- 0.1.2
  - support control ensure button title
  - support modify day color
- 0.1.1
  - support continuous selection
  - support custom headerView 
  - support modify widgets height
  - fix bug
- 0.1.0
  - simple calendart
  - Initial release
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
some support cofigures class 

```dart
import 'package:flutter/material.dart';

enum TWCalendarListSeletedMode {
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

  /// 月历配置对象
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

  /// 确认按钮字体颜色
  final Color? ensureTitleColor;

  /// 确定按钮 decoration
  final Decoration? ensureViewDecoration;
}

/* 月历视图部分 */
class TWCalendarMonthViewConfig {
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
}

class TWCalendarDayNumberConfig {
  /// 今天颜色
  final Color? todayBackgroudColor;

  /// 今天颜色
  final Color? todayTitleColor;

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
  )? widgetHandler;

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
}

```

example

```dart

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar Demo'),
        ),
        body: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  /// 弹出框日历，默认连续选择
  _showNavigateDailog(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return const TWCalendarView();
      },
    );
  }

  /// 弹出框日历-多选不连续
  _showNavigateMutilpleDailog(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return const TWCalendarMutilpleView();
      },
    );
  }

  /// 弹出框日历-多选不连续
  _showNavigateCustomDateDailog(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return const TWCalendarCustomDateWidgetView();
      },
    );
  }

  /// 弹出框日历-推荐日期
  _showNavigateRecommendDailog(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BiddingCalendarView(
          models: [
            BiddingDayChoiceModel(),
            BiddingDayChoiceModel(dayCount: 21),
            BiddingDayChoiceModel(dayCount: 15),
            BiddingDayChoiceModel(dayCount: 7),
            BiddingDayChoiceModel(dayCount: 3),
          ],
          lastDate: TWCalendarTool.nowAfterDays(88),
          selectedStartDate: TWCalendarTool.nowAfterDays(2),
          selectedEndDate: TWCalendarTool.nowAfterDays(10),
          onSelectFinish: (
            selectStartTime,
            selectEndTime,
            notSerialSelectedTimes,
          ) {
            print(
                'selectStartTime : $selectStartTime, selectEndTime : $selectEndTime');
            Navigator.pop(context);
          },
          onSelectDayRang: ((seletedDate, seletedDays) {
            print('seletedDate: $seletedDate, seletedDays: $seletedDays');
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextButton(
            child: const Text('Calendar: Mutilple Serial Date Selected'),
            onPressed: () {
              _showNavigateDailog(context);
            },
          ),
          TextButton(
            child: const Text('Calendar: Custom Header Widget'),
            onPressed: () {
              _showNavigateRecommendDailog(context);
            },
          ),
          TextButton(
            child: const Text('Calendar: Mutilple NotSerial Date Selected'),
            onPressed: () {
              _showNavigateMutilpleDailog(context);
            },
          ),
          TextButton(
            child: const Text('Calendar: Custom Date Widget'),
            onPressed: () {
              _showNavigateCustomDateDailog(context);
            },
          ),
        ],
      ),
    );
  }
}

class TWCalendarView extends StatefulWidget {
  const TWCalendarView({
    Key? key,
  }) : super(key: key);

  @override
  TWCalendarViewState createState() => TWCalendarViewState();
}

class TWCalendarViewState extends State<TWCalendarView> {
  late TWCalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = TWCalendarController(
      firstDate: TWCalendarTool.today,
      lastDate: TWCalendarTool.nowAfterDays(33),
      selectedStartDate: TWCalendarTool.nowAfterDays(2),
      selectedEndDate: TWCalendarTool.nowAfterDays(10),
      onSelectDayRang: ((seletedDate, seletedDays) {
        print(
            'onSelectDayRang => seletedDate : $seletedDate, seletedDays : $seletedDays');
      }),
      onSelectDayTitle: (selectStartTime, selectEndTime, seletedDays) {
        print(
            'onSelectDayTitle => selectStartTime : $selectStartTime, selectEndTime : $selectEndTime, seletedDays : $seletedDays');
        if (selectStartTime != null && selectEndTime != null) {
          return "ensure (${selectStartTime.year},${selectStartTime.month},${selectStartTime.day} - ${selectEndTime.year},${selectEndTime.month},${selectEndTime.day}）";
        }
        return "please choice...";
      },
      onSelectFinish: (
        selectStartTime,
        selectEndTime,
        notSerialSelectedTimes,
      ) {
        print(
            'onSelectFinish => selectStartTime : $selectStartTime, selectEndTime : $selectEndTime');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TWCalendarList(
      calendarController: controller,
      configs: TWCalendarConfigs(
        listConfig: TWCalendarListConfig(
          seletedMode: TWCalendarListSeletedMode.doubleSerial,
          ensureViewSelectedColor: Colors.blue,
        ),
        monthViewConfig: TWCalendarMonthViewConfig(
          monthBodyHeight: 300.w,
          canSelectedToday: true,
          titleHandler: ((year, month) => '$year - $month'),
        ),
        dayNumberConfig: TWCalendarDayNumberConfig(
          selectedBackgroundColor: Colors.blue,
          todayBackgroudColor: Colors.red,
          todyTitle: 'today',
        ),
        weekdayRowConfig: TWCalendarWeekdayRowConfig(
          titleFontSize: 14.w,
          titleColor: Colors.blue,
          titles: [
            'Sun',
            'Mon',
            'Tues',
            'Wed',
            'Thurs',
            'Fri',
            'Satur',
          ],
        ),
      ),
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          'Calendar Widget',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TWCalendarMutilpleView extends StatefulWidget {
  const TWCalendarMutilpleView({
    Key? key,
  }) : super(key: key);

  @override
  TWCalendarMutilpleViewState createState() => TWCalendarMutilpleViewState();
}

class TWCalendarMutilpleViewState extends State<TWCalendarMutilpleView> {
  late TWCalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = TWCalendarController(
      firstDate: TWCalendarTool.today,
      lastDate: TWCalendarTool.nowAfterDays(33),
      notSerialSelectedDates: [
        TWCalendarTool.nowAfterDays(1),
        TWCalendarTool.nowAfterDays(3),
        TWCalendarTool.nowAfterDays(5),
        TWCalendarTool.nowAfterDays(7),
      ],
      onSelectDayRang: ((seletedDate, seletedDays) {
        print(
            'onSelectDayRang => onSelectDayRang => seletedDate : $seletedDate, seletedDays : $seletedDays');
      }),
      onSelectFinish: (selectStartTime, selectEndTime, notSerialSelectedTimes) {
        print(
            'onSelectFinish => onSelectFinish => selectStartTime : $selectStartTime, selectEndTime : $selectEndTime, notSerialSelectedTimes: $notSerialSelectedTimes');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TWCalendarList(
      calendarController: controller,
      configs: TWCalendarConfigs(
        listConfig: TWCalendarListConfig(
          seletedMode: TWCalendarListSeletedMode.notSerial,
        ),
        monthViewConfig: TWCalendarMonthViewConfig(
          monthBodyHeight: 300.w,
        ),
      ),
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          'Mutilple Not Serial Date Widget',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TWCalendarCustomDateWidgetView extends StatefulWidget {
  const TWCalendarCustomDateWidgetView({
    Key? key,
  }) : super(key: key);

  @override
  TWCalendarCustomDateWidgetViewState createState() =>
      TWCalendarCustomDateWidgetViewState();
}

class TWCalendarCustomDateWidgetViewState
    extends State<TWCalendarCustomDateWidgetView> {
  late TWCalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = TWCalendarController(
      firstDate: TWCalendarTool.today,
      lastDate: TWCalendarTool.nowAfterDays(33),
      onSelectDayRang: ((seletedDate, seletedDays) {
        print(
            'onSelectDayRang => onSelectDayRang => seletedDate : $seletedDate, seletedDays : $seletedDays');
      }),
      onSelectFinish: (selectStartTime, selectEndTime, notSerialSelectedTimes) {
        print(
            'onSelectFinish => onSelectFinish => selectStartTime : $selectStartTime, selectEndTime : $selectEndTime, notSerialSelectedTimes: $notSerialSelectedTimes');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TWCalendarList(
      calendarController: controller,
      configs: TWCalendarConfigs(
        listConfig: TWCalendarListConfig(
          seletedMode: TWCalendarListSeletedMode.notSerial,
        ),
        monthViewConfig: TWCalendarMonthViewConfig(
          monthBodyHeight: 300.w,
        ),
        dayNumberConfig: TWCalendarDayNumberConfig(
          widgetHandler: (
            year,
            month,
            day,
            size,
            isSelected,
            isToday,
            canSelected,
          ) {
            bool tomorrow = TWCalendarTool.isSameDate(
              TWCalendarTool.tomorrow,
              DateTime(year, month, day),
            );
            return SizedBox(
              width: size,
              height: size,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: canSelected
                      ? (isSelected
                          ? Colors.orange.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1))
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tomorrow ? '明天' : (isToday ? '今天' : '$day'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: canSelected
                            ? (isSelected ? Colors.red : Colors.black)
                            : Colors.grey,
                      ),
                    ),
                    if (tomorrow && canSelected)
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: (isSelected ? Colors.red : Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    else
                      Icon(
                        Icons.favorite,
                        color: (isSelected ? Colors.pink : Colors.black),
                        size: 10.0,
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          'Calendar Custom Date Widget',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

```

## thx
thank you ,and modify form this demo. [flutter_calendar_list](https://github.com/heruijun/flutter_calendar_list)
