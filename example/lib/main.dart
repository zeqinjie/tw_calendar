/*
 * @Author: zhengzeqin
 * @Date: 2022-07-24 16:01:25
 * @LastEditTime: 2022-07-24 20:44:46
 * @Description: 日历组件
 */

import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_calendar_list.dart';
import 'package:tw_calendar/utils/tw_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  _TWCalendarViewState createState() => _TWCalendarViewState();
}

class _TWCalendarViewState extends State<TWCalendarView> {
  @override
  Widget build(BuildContext context) {
    return TWCalendarList(
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
    );
  }
}
