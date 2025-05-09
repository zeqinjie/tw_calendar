/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 22:10:08
 * @LastEditTime: 2022-09-25 15:45:27
 * @Description: 日历组件
 */

import 'package:flutter/material.dart';
import 'package:tw_calendar/tw_calendar_controller.dart';
import 'tw_calendar_configs.dart';
import 'tw_month_view.dart';
import 'tw_weekday_row.dart';
import 'utils/tw_calendar_tool.dart';

class TWCalendarList extends StatefulWidget {
  /// 头部组件
  final Widget? headerView;

  /// 日历数据控制器
  final TWCalendarController calendarController;

  /// 配置对象
  final TWCalendarConfigs? configs;

  const TWCalendarList({
    Key? key,
    required this.calendarController,
    this.configs,
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

  /// 不连续选择的日期数组
  List<DateTime> notSerialSelectedTimes = [];

  /// 选中了多少天
  int selectedDays = 0;

  TWCalendarListSelectedMode selectedMode =
      TWCalendarListSelectedMode.singleSerial;

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

  /* Handle Date Method */
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

    selectedMode = widget.configs?.listConfig?.selectedMode ??
        TWCalendarListSelectedMode.singleSerial;
    // 📢 非连续的选择数组非空，则 selectedMode = TWCalendarListSelectedMode.notSerial;
    if (widget.calendarController.notSerialSelectedDates != null) {
      notSerialSelectedTimes =
          widget.calendarController.notSerialSelectedDates!;
      _handleMultipleStartEndTime();
      selectedMode = TWCalendarListSelectedMode.notSerial;
    }
    // 初始化选择天数
    _updateSelectedDays();
  }

  /* UI Method */
  Widget _buildBody() {
    Widget monthView;
    if (widget.configs?.monthViewConfig?.monthBodyHeight != null) {
      monthView = SizedBox(
        height: widget.configs?.monthViewConfig?.monthBodyHeight,
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
            height: widget.configs?.weekdayRowConfig?.weekDayHeight ?? 48,
            child: _buildWeekdayView(),
          ),
          monthView,
          SizedBox(
            height: widget.configs?.listConfig?.ensureViewHeight ?? 66,
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
        left: widget.configs?.listConfig?.horizontalSpace ?? 8,
        right: widget.configs?.listConfig?.horizontalSpace ?? 8,
      ),
      child: TWWeekdayRow(
        weekdayRowConfig: widget.configs?.weekdayRowConfig,
      ),
    );
  }

  Widget _buildEnsureView() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: widget.configs?.listConfig?.ensureViewPadding ??
          const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 12,
            bottom: 12,
          ),
      decoration: widget.configs?.listConfig?.ensureViewDecoration ??
          _buildBoxDecoration(),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: TextButton(
          onPressed: _finishSelect,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              _isHadSelectedDate
                  ? widget.configs?.listConfig?.ensureViewSelectedColor ??
                      const Color(0XFFFF8000)
                  : widget.configs?.listConfig?.ensureViewUnSelectedColor ??
                      const Color(0XFFB3B3B3),
            ),
          ),
          child: Text(
            _getEnsureTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.configs?.listConfig?.ensureTitleFontSize ?? 16,
              color:
                  widget.configs?.listConfig?.ensureTitleColor ?? Colors.white,
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
      notSerialSelectedTimes: notSerialSelectedTimes,
      selectStartDateTime: selectStartTime,
      selectEndDateTime: selectEndTime,
      onSelectDayRang: (dateTime) => _onSelectDayChanged(dateTime),
      isMaxSelectedDays: isMaxSelectedDays,
      isMinSelectedDays: isMinSelectedDays,
    );
  }
}

/* Private Method */
/// 数据处理
extension TWCalendarListStateHandler on TWCalendarListState {
  /// 是否有选择日期
  bool get _isHadSelectedDate {
    // 小余最小选择天数或者大于最大选择天数
    if (isMaxSelectedDays || isMinSelectedDays) {
      return false;
    }
    // 未选择日期
    return selectStartTime != null ||
        (selectStartTime != null && selectEndTime != null) ||
        notSerialSelectedTimes.isNotEmpty;
  }

  /// 获取确认按钮 title
  String get _getEnsureTitle {
    String btnTitle = '確   定';
    final selectedDaysTitle = TWCalendarTool.getSelectedDaysTitle(
      selectStartTime,
      selectEndTime,
    );
    if (selectedDays != 0) {
      btnTitle = '確定 ($selectedDaysTitle 共$selectedDays天)';
    }
    if (widget.calendarController.onSelectDayTitle != null) {
      return widget.calendarController.onSelectDayTitle!(
        selectStartTime,
        selectEndTime,
        selectedDays,
      );
    }
    return btnTitle;
  }

  /// 处理多选数据
  void _handleMultipleTimes(DateTime dateTime) {
    if (TWCalendarTool.isHadSelected(
      selectedTimes: notSerialSelectedTimes,
      dateTime: dateTime,
    )) {
      TWCalendarTool.removeSelected(
        selectedTimes: notSerialSelectedTimes,
        dateTime: dateTime,
      );
    } else {
      notSerialSelectedTimes.add(dateTime);
    }
    _handleMultipleStartEndTime();
  }

  /// 处理开始与结束日期
  void _handleMultipleStartEndTime() {
    TWCalendarTool.sortDateTimes(notSerialSelectedTimes);
    final count = notSerialSelectedTimes.length;
    if (count == 0) {
      selectStartTime = null;
      selectEndTime = null;
    } else {
      selectStartTime = notSerialSelectedTimes.first;
      selectEndTime = notSerialSelectedTimes.last;
    }
  }

  /// 更新选择天数
  void _updateSelectedDays() {
    if (selectedMode == TWCalendarListSelectedMode.notSerial) {
      selectedDays = notSerialSelectedTimes.length;
    } else {
      selectedDays =
          TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
    }
  }

  /// 选项处理回调
  void _onSelectDayChanged(DateTime dateTime) {
    switch (selectedMode) {
      case TWCalendarListSelectedMode.notSerial:
        _handleMultipleTimes(dateTime);
        break;
      case TWCalendarListSelectedMode.doubleSerial:
        if (selectStartTime == null && selectEndTime == null) {
          selectStartTime = dateTime;
        } else if (selectStartTime != null && selectEndTime == null) {
          selectEndTime = dateTime;
          // 如果选择的开始日期和结束日期相等，则清除选项
          if (selectStartTime == selectEndTime) {
            // ignore: invalid_use_of_protected_member
            setState(() {
              selectStartTime = null;
              selectEndTime = null;
            });
            selectedDays = 0;
            _handleSelectDayRang(dateTime);
            return;
          }
          // 如果用户反选，则交换开始和结束日期
          if (selectStartTime!.isAfter(selectEndTime!)) {
            DateTime temp = selectStartTime!;
            selectStartTime = selectEndTime;
            selectEndTime = temp;
          }
        } else if (selectStartTime != null && selectEndTime != null) {
          selectEndTime = null;
          selectStartTime = dateTime;
        }
        break;
      default:
        selectStartTime = widget.calendarController.firstDate;
        selectEndTime = dateTime;
    }
    // ignore: invalid_use_of_protected_member
    setState(() {
      _updateSelectedDays();
    });

    _handleSelectDayRang(dateTime);
  }

  void _handleSelectDayRang(DateTime dateTime) {
    if (widget.calendarController.onSelectDayRang != null) {
      widget.calendarController.onSelectDayRang!(dateTime, selectedDays);
    }
  }

  void _finishSelect() {
    if (widget.calendarController.onSelectFinish != null) {
      if ((selectStartTime != null && selectEndTime != null) ||
          notSerialSelectedTimes.isNotEmpty) {
        widget.calendarController.onSelectFinish!(
          selectStartTime,
          selectEndTime,
          notSerialSelectedTimes,
          selectedDays,
        );
      }
    }
  }
}

extension TWCalendarListStateForMaxAndMin on TWCalendarListState {
  /// 最大选择天数
  bool get isMaxSelectedDays {
    final maxSelectedDays = widget.configs?.listConfig?.maxSelectDays;
    if (maxSelectedDays != null && selectedDays > maxSelectedDays) {
      return true;
    }
    return false;
  }

  /// 最小选择天数
  bool get isMinSelectedDays {
    final minSelectedDays = widget.configs?.listConfig?.minSelectDays;
    if (minSelectedDays != null && selectedDays < minSelectedDays) {
      return true;
    }
    return false;
  }
}
