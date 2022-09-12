/*
 * @Author: zhengzeqin
 * @Date: 2022-08-28 13:22:42
 * @LastEditTime: 2022-09-12 13:53:03
 * @Description: your project
 */
import 'package:tw_calendar/tw_calendar_list.dart';

class TWCalendarController {
  /// 可以选择开始的年月份
  final DateTime firstDate;

  /// 可以选择结束的年月份
  final DateTime lastDate;

  /// 选择开始日期
  DateTime? selectedStartDate;

  /// 选择结束日期
  DateTime? selectedEndDate;

  /// 不连续选择的日期数组, 注意选择类型 TWCalendarListSeletedMode.multiple
  List<DateTime>? mutipleSelectedDates;

  /// 点击确定回调
  final void Function(DateTime? selectStartTime, DateTime? selectEndTime)?
      onSelectFinish;

  /// 每次选择日期回调
  final void Function(DateTime seletedDate, int seletedDays)? onSelectDayRang;

  /// 更新确定按钮 title 回调
  final String Function(
          DateTime? selectStartTime, DateTime? selectEndTime, int seletedDays)?
      onSelectDayTitle;

  TWCalendarListState? state;

  TWCalendarController({
    required this.firstDate,
    required this.lastDate,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onSelectFinish,
    this.onSelectDayRang,
    this.onSelectDayTitle,
  }) : assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate');

  /// 更新数据
  void updateData() {
    state?.initData();
  }
}
