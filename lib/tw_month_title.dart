/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-09-04 09:06:21
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'tw_calendar_cofigs.dart';
import 'utils/tw_calendart_tool.dart';

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
    final yearTitle = TWCalendarTool.getYearName(year);
    final title = yearTitle + monthTitle;
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
