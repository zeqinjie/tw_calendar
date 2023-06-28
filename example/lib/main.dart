/*
 * @Author: zhengzeqin
 * @Date: 2022-07-24 16:01:25
 * @LastEditTime: 2022-10-04 13:43:03
 * @Description: 日历组件
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tw_calendar/tw_calendar.dart';
import 'package:tw_calendar_example/feature/bidding_day_choice_model.dart';
import 'feature/bidding_calendar_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

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
  _showNavigateDialog(BuildContext context) {
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
  _showNavigateMultipleDialog(BuildContext context) {
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
        return const TWCalendarMultipleView();
      },
    );
  }

  /// 弹出框日历-多选不连续
  _showNavigateCustomDateDialog(BuildContext context) {
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
  _showNavigateRecommendDialog(BuildContext context) {
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
            child: const Text('Calendar: Multiple Double Serial Date Selected'),
            onPressed: () {
              _showNavigateDialog(context);
            },
          ),
          TextButton(
            child: const Text('Calendar: Custom Header Widget'),
            onPressed: () {
              _showNavigateRecommendDialog(context);
            },
          ),
          TextButton(
            child: const Text('Calendar: Multiple NotSerial Date Selected'),
            onPressed: () {
              _showNavigateMultipleDialog(context);
            },
          ),
          TextButton(
            child: const Text('Calendar: Custom Date Widget'),
            onPressed: () {
              _showNavigateCustomDateDialog(context);
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
      lastDate: TWCalendarTool.nowAfterDays(20),
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
          selectedMode: TWCalendarListSelectedMode.doubleSerial,
          ensureViewSelectedColor: Colors.blue,
        ),
        monthViewConfig: TWCalendarMonthViewConfig(
          monthBodyHeight: 300.w,
          canSelectedToday: true,
          sortOffset: 1,
          titleHandler: ((year, month) => '$year - $month'),
        ),
        dayNumberConfig: TWCalendarDayNumberConfig(
          selectedBackgroundColor: Colors.blue,
          todayBackgroundColor: Colors.red,
          todyTitle: 'today',
        ),
        weekdayRowConfig: TWCalendarWeekdayRowConfig(
          titleFontSize: 14.w,
          titleColor: Colors.blue,
          titles: [
            'Mon',
            'Tues',
            'Wed',
            'Thurs',
            'Fri',
            'Satur',
            'Sun',
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

class TWCalendarMultipleView extends StatefulWidget {
  const TWCalendarMultipleView({
    Key? key,
  }) : super(key: key);

  @override
  TWCalendarMultipleViewState createState() => TWCalendarMultipleViewState();
}

class TWCalendarMultipleViewState extends State<TWCalendarMultipleView> {
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
          selectedMode: TWCalendarListSelectedMode.notSerial,
        ),
        monthViewConfig: TWCalendarMonthViewConfig(
          monthBodyHeight: 300.w,
        ),
      ),
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          'Multiple Not Serial Date Widget',
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
          selectedMode: TWCalendarListSelectedMode.notSerial,
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
