/*
 * @Author: zhengzeqin
 * @Date: 2022-07-24 16:01:25
 * @LastEditTime: 2022-09-25 15:34:06
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
            child: const Text('弹出框日历'),
            onPressed: () {
              _showNavigateDailog(context);
            },
          ),
          TextButton(
            child: const Text('弹出框日历-推荐日期'),
            onPressed: () {
              _showNavigateRecommendDailog(context);
            },
          ),
          TextButton(
            child: const Text('弹出框日历-多选不连续'),
            onPressed: () {
              _showNavigateMutilpleDailog(context);
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
          'Calendar Mutilple Widget',
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
