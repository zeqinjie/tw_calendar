/*
 * @Author: zhengzeqin
 * @Date: 2022-07-21 18:14:31
 * @LastEditTime: 2022-09-03 22:29:44
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_calendar_cofigs.dart';
import 'package:tw_calendar/tw_calendar_controller.dart';
import 'package:tw_calendar/tw_calendar_list.dart';
import 'package:tw_calendar/utils/tw_calendart_tool.dart';
import 'package:tw_calendar_example/feature/bidding_calendar_header_view.dart';
import 'package:tw_calendar_example/feature/bidding_day_choice_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiddingCalendarView extends StatefulWidget {
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final DateTime lastDate;
  final List<BiddingDayChoiceModel>? models;
  final void Function(DateTime? selectStartTime, DateTime? selectEndTime)?
      onSelectFinish;
  final void Function(DateTime seletedDate, int seletedDays)? onSelectDayRang;
  const BiddingCalendarView({
    Key? key,
    this.selectedStartDate,
    this.selectedEndDate,
    required this.lastDate,
    this.models,
    this.onSelectFinish,
    this.onSelectDayRang,
  }) : super(key: key);

  @override
  State<BiddingCalendarView> createState() => _BiddingCalendarViewState();
}

class _BiddingCalendarViewState extends State<BiddingCalendarView> {
  List<BiddingDayChoiceModel>? models;
  late final TWCalendarController controller;
  @override
  void initState() {
    super.initState();
    controller = TWCalendarController(
      firstDate: TWCalendarTool.tomorrow,
      lastDate: widget.lastDate,
      selectedStartDate: widget.selectedStartDate,
      selectedEndDate: widget.selectedEndDate,
      onSelectFinish: widget.onSelectFinish,
      onSelectDayRang: (seletedDate, seletedDays) {
        handerSeletedDate(seletedDate, seletedDays);
        if (widget.onSelectDayRang != null) {
          widget.onSelectDayRang!(seletedDate, seletedDays);
        }
      },
    );
    models = widget.models;
  }

  /* UI Method */
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.8,
      child: TWCalendarList(
        configs: TWCalendarConfigs(),
        calendarController: controller,
        headerView: _buildHeader(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BiddingCalendarHeaderView(
      models: widget.models,
      onTap: (index, model) {
        handerDayChoice(model);
      },
    );
  }

  void handerDayChoice(BiddingDayChoiceModel model) {
    setState(() {
      int dayCount = model.dayCount;
      updateSelectedDays(dayCount);
      resetChoice();
      model.isChoice = true;
      controller.updateData();
    });
  }

  void updateSelectedDays(int day) {
    controller.selectedStartDate = DateTime.now().tomorrow();
    if (day > 1) {
      controller.selectedEndDate = DateTime.now().afterDays(days: day);
    }
  }

  void handerSeletedDate(DateTime seletedDate, int seletedDays) {
    setState(() {
      controller.selectedStartDate = DateTime.now().tomorrow();
      controller.selectedEndDate = seletedDate;
      models?.forEach((element) {
        element.isChoice = element.dayCount == seletedDays;
      });
    });
  }

  void resetChoice() {
    models?.forEach((element) {
      element.isChoice = false;
    });
  }
}

extension TWDateExtension on DateTime {
  DateTime tomorrow() {
    return afterDays(days: 1);
  }

  DateTime afterDays({int days = 1}) {
    return add(Duration(days: days));
  }

  DateTime secondYear() {
    return add(const Duration(days: 365));
  }
}
