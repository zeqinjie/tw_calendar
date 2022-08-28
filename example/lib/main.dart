/*
 * @Author: zhengzeqin
 * @Date: 2022-07-24 16:01:25
 * @LastEditTime: 2022-08-28 22:45:27
 * @Description: 日历组件
 */

import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_calendar_cofigs.dart';
import 'package:tw_calendar/tw_calendar_controller.dart';
import 'package:tw_calendar/tw_calendar_list.dart';
import 'package:tw_calendar/utils/tw_calendart_tool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          title: const Text('日历 demo'),
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
  // Dialog方式
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
          lastDate: DateTime(2022, 11, 21),
          selectedStartDate: DateTime(2022, 9, 2),
          selectedEndDate: DateTime(2022, 9, 10),
          onSelectFinish: (selectStartTime, selectEndTime) {
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
      firstDate: TWCalendarTool.tomorrow,
      lastDate: DateTime(2022, 11, 21),
      selectedStartDate: DateTime(2022, 9, 2),
      selectedEndDate: DateTime(2022, 9, 10),
      onSelectDayRang: ((seletedDate, seletedDays) {
        print('seletedDate : $seletedDate, seletedDays : $seletedDays');
      }),
      onSelectDayTitle: (selectStartTime, selectEndTime, seletedDays) {
        print(
            'selectStartTime : $selectStartTime, selectEndTime : $selectEndTime, seletedDays : $seletedDays');
        return "确 定 (${selectStartTime?.month}月${selectStartTime?.day}日 - ${selectEndTime?.month}月${selectEndTime?.day}日）";
      },
      onSelectFinish: (selectStartTime, selectEndTime) {
        print(
            'selectStartTime : $selectStartTime, selectEndTime : $selectEndTime');
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
          ensureViewSelectedColor: Colors.blue,
          dayNumberSelectedColor: Colors.orange,
          dayNumberTodayColor: Colors.green,
        ),
        monthViewConfig: TWCalendarMonthViewConfig(
          monthBodyHeight: 300.w,
        ),
      ),
      seletedMode: TWCalendarListSeletedMode.singleSerial,
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          '日历组件',
          style: TextStyle(
            color: const Color(0XFF333333),
            fontSize: 18.w,
          ),
        ),
      ),
    );
  }
}
