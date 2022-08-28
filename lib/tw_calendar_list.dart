/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 22:10:08
 * @LastEditTime: 2022-08-28 16:02:50
 * @Description: 日历组件
 */
library calendar_list;

import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_calendar_controller.dart';
import 'tw_calendar_cofigs.dart';
import 'tw_month_view.dart';
import 'tw_weekday_row.dart';
import 'utils/tw_calendart_tool.dart';

enum TWCalendarListSeletedMode {
  /// 默认选择是连续多选
  defaltSerial,

  /// 单选连续,从可选日开始
  singleSerial,
}

class TWCalendarList extends StatefulWidget {
  /// 头部组件
  final Widget? headerView;

  /// 选择模式
  final TWCalendarListSeletedMode? seletedMode;

  final TWCalendarController calendarController;

  final TWCalendarConfigs configs;

  const TWCalendarList({
    Key? key,
    required this.calendarController,
    required this.configs,
    this.headerView,
    this.seletedMode,
  }) : super(key: key);

  @override
  TWCalendarListState createState() => TWCalendarListState();
}

class TWCalendarListState extends State<TWCalendarList> {
  /// 选择开始日期
  late DateTime? selectStartTime;

  /// 选择结束日期
  late DateTime? selectEndTime;

  /// 开始年份
  late int yearStart;

  /// 结束年份
  late int yearEnd;

  /// 开始月份
  late int monthStart;

  /// 结束月份
  late int monthEnd;

  /// 间隔多少月
  late int count;

  /// 选中了多少天
  int seletedDays = 0;

  @override
  void initState() {
    super.initState();
    widget.calendarController.state = this;
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  /* UI Method */
  Widget _buildBody() {
    Widget monthView;
    if (widget.configs.listConfig?.monthBodyHeight != null) {
      monthView = SizedBox(
        height: widget.configs.listConfig?.monthBodyHeight,
        child: _buildMonthView(),
      );
    } else {
      monthView = Expanded(child: _buildMonthView());
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.headerView != null) widget.headerView!,
          SizedBox(
            height: widget.configs.listConfig?.weekDayHeight ?? 48,
            child: _buildWeekdayView(),
          ),
          monthView,
          SizedBox(
            height: widget.configs.listConfig?.ensureViewHeight ?? 66,
            child: _buildEnsureView(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayView() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0XFFF5F5F5),
            offset: Offset(0, -0.5),
            blurRadius: 1.0,
          )
        ],
      ),
      padding: EdgeInsets.only(
        left: widget.configs.listConfig?.horizontalSpace ?? 8,
        right: widget.configs.listConfig?.horizontalSpace ?? 8,
      ),
      child: const TWWeekdayRow(),
    );
  }

  Widget _buildEnsureView() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: widget.configs.listConfig?.ensureViewPadding ??
          const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 12,
            bottom: 12,
          ),
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0XFFFFFFFF),
            offset: Offset(0, -0.5),
            blurRadius: 1.0,
          )
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: TextButton(
          onPressed: _finishSelect,
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
                (selectStartTime != null ||
                        (selectStartTime != null && selectEndTime != null))
                    ? widget.configs.listConfig?.ensureViewSelectedColor
                    : widget.configs.listConfig?.ensureViewUnSelectedColor),
          ),
          child: Text(
            _getEnsureTitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.configs.listConfig?.ensureTitleFontSize ?? 16,
              color: const Color(0XFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthView() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0XFFF5F5F5),
            offset: Offset(0, -0.5),
            blurRadius: 1.0,
          )
        ],
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                int month = index + monthStart;
                DateTime calendarDateTime = DateTime(yearStart, month);
                return _getMonthView(calendarDateTime);
              },
              childCount: count,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMonthView(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    return TWMonthView(
      context: context,
      year: year,
      month: month,
      padding: widget.configs.listConfig?.horizontalSpace ?? 8,
      firstDate: widget.calendarController.firstDate,
      lastDate: widget.calendarController.lastDate,
      selectStartDateTime: selectStartTime,
      selectEndDateTime: selectEndTime,
      todayColor: widget.configs.listConfig?.dayNumberTodayColor,
      selectedColor: widget.configs.listConfig?.dayNumberSelectedColor,
      onSelectDayRang: (dateTime) => _onSelectDayChanged(dateTime),
    );
  }

  void initData() {
    // 传入的选择开始日期
    selectStartTime = widget.calendarController.selectedStartDate;
    // 传入的选择结束日期
    selectEndTime = widget.calendarController.selectedEndDate;
    // 开始年份
    yearStart = widget.calendarController.firstDate.year;
    // 结束年份
    yearEnd = widget.calendarController.lastDate.year;
    // 开始月份
    monthStart = widget.calendarController.firstDate.month;
    // 结束月份
    monthEnd = widget.calendarController.lastDate.month;
    // 总月数
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;

    seletedDays =
        TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
  }

  /* Private Method */
  /// 获取确认按钮 title
  String _getEnsureTitle() {
    String btnTitle = '確   定';
    final selectedDaysTitle =
        TWCalendarTool.getSelectedDaysTitle(selectStartTime, selectEndTime);
    if (seletedDays != 0) {
      btnTitle = '確定 ($selectedDaysTitle 共$seletedDays天)';
    }
    if (widget.calendarController.onSelectDayTitle != null) {
      return widget.calendarController.onSelectDayTitle!(
          selectStartTime, selectEndTime, seletedDays);
    }
    return btnTitle;
  }

  // 选项处理回调
  void _onSelectDayChanged(DateTime dateTime) {
    switch (widget.seletedMode) {
      case TWCalendarListSeletedMode.singleSerial:
        selectStartTime = widget.calendarController.firstDate;
        selectEndTime = dateTime;
        break;
      default:
        if (selectStartTime == null && selectEndTime == null) {
          selectStartTime = dateTime;
        } else if (selectStartTime != null && selectEndTime == null) {
          selectEndTime = dateTime;
          // 如果选择的开始日期和结束日期相等，则清除选项
          if (selectStartTime == selectEndTime) {
            setState(() {
              selectStartTime = null;
              selectEndTime = null;
            });
            seletedDays = 0;
            _handerSelectDayRang(dateTime);
            return;
          }
          // 如果用户反选，则交换开始和结束日期
          if (selectStartTime!.isAfter(selectEndTime!)) {
            DateTime temp = selectStartTime!;
            selectStartTime = selectEndTime;
            selectEndTime = temp;
          }
        } else if (selectStartTime != null && selectEndTime != null) {
          selectStartTime = null;
          selectEndTime = null;
          selectStartTime = dateTime;
        }
    }
    seletedDays =
        TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
    _handerSelectDayRang(dateTime);
    setState(() {
      selectStartTime;
      selectEndTime;
    });
  }

  void _handerSelectDayRang(DateTime dateTime) {
    if (widget.calendarController.onSelectDayRang != null) {
      widget.calendarController.onSelectDayRang!(dateTime, seletedDays);
    }
  }

  void _finishSelect() {
    if (widget.calendarController.onSelectFinish != null) {
      widget.calendarController.onSelectFinish!(selectStartTime, selectEndTime);
    }
  }
}
