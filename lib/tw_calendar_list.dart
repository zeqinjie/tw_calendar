/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 22:10:08
 * @LastEditTime: 2022-09-04 09:47:17
 * @Description: 日历组件
 */
library calendar_list;

import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_calendar_controller.dart';
import 'tw_calendar_cofigs.dart';
import 'tw_month_view.dart';
import 'tw_weekday_row.dart';
import 'utils/tw_calendart_tool.dart';

class TWCalendarList extends StatefulWidget {
  /// 头部组件
  final Widget? headerView;

  /// 日历数据控制器
  final TWCalendarController calendarController;

  /// 配置对象
  final TWCalendarConfigs configs;

  const TWCalendarList({
    Key? key,
    required this.calendarController,
    required this.configs,
    this.headerView,
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
    if (widget.configs.monthViewConfig?.monthBodyHeight != null) {
      monthView = SizedBox(
        height: widget.configs.monthViewConfig?.monthBodyHeight,
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
            height: widget.configs.weekdayRowConfig?.weekDayHeight ?? 48,
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
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.only(
        left: widget.configs.listConfig?.horizontalSpace ?? 8,
        right: widget.configs.listConfig?.horizontalSpace ?? 8,
      ),
      child: TWWeekdayRow(
        weekdayRowConfig: widget.configs.weekdayRowConfig,
      ),
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
      decoration: widget.configs.listConfig?.ensureViewDecoration ??
          _buildBoxDecoration(),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: TextButton(
          onPressed: _finishSelect,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                (selectStartTime != null ||
                        (selectStartTime != null && selectEndTime != null))
                    ? widget.configs.listConfig?.ensureViewSelectedColor ??
                        const Color(0XFFFF8000)
                    : widget.configs.listConfig?.ensureViewUnSelectedColor ??
                        const Color(0XFFB3B3B3)),
          ),
          child: Text(
            _getEnsureTitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.configs.listConfig?.ensureTitleFontSize ?? 16,
              color:
                  widget.configs.listConfig?.ensureTitleColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0XFFF5F5F5),
              offset: Offset(0, -0.5),
              blurRadius: 1.0,
            )
          ],
        );
  }

  Widget _buildMonthView() {
    return Container(
      decoration: _buildBoxDecoration(),
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
      configs: widget.configs,
      year: year,
      month: month,
      firstDate: widget.calendarController.firstDate,
      lastDate: widget.calendarController.lastDate,
      selectStartDateTime: selectStartTime,
      selectEndDateTime: selectEndTime,
      onSelectDayRang: (dateTime) => _onSelectDayChanged(dateTime),
    );
  }

  void initData() {
    // 传入的选择开始日期
    selectStartTime =
        TWCalendarTool.onlyDay(widget.calendarController.selectedStartDate);
    // 传入的选择结束日期
    selectEndTime =
        TWCalendarTool.onlyDay(widget.calendarController.selectedEndDate);
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
    var seletedMode = widget.configs.listConfig?.seletedMode ??
        TWCalendarListSeletedMode.singleSerial;
    switch (seletedMode) {
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
    setState(() {
      seletedDays =
        TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
    });
    _handerSelectDayRang(dateTime);
    
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
