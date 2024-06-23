/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-10-04 12:51:41
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'tw_calendar_configs.dart';
import 'utils/tw_calendar_tool.dart';

class TWMonthTitle extends StatelessWidget {
  final int month;
  final int year;

  /// 月历配置对象
  final TWCalendarMonthViewConfig? monthViewConfig;
  const TWMonthTitle({
    Key? key,
    required this.month,
    required this.year,
    this.monthViewConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthTitle = TWCalendarTool.getMonthName(
      month,
      monthNames: monthViewConfig?.monthNames,
    );
    final yearTitle = TWCalendarTool.getYearName(
      year,
      title: monthViewConfig?.yearTitle,
    );
    var title = yearTitle + monthTitle;
    if (monthViewConfig?.titleHandler != null) {
      title = monthViewConfig?.titleHandler!(year, month) ?? '';
    }
    return Text(
      title,
      style: TextStyle(
        fontSize: monthViewConfig?.titleFontSize ?? 16,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
