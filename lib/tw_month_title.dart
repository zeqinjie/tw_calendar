/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-29 10:47:15
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'utils/tw_calendart_tool.dart';

class TWMonthTitle extends StatelessWidget {
  const TWMonthTitle({
    Key? key,
    required this.month,
    required this.year,
    this.monthNames,
    this.fontSize,
  }) : super(key: key);

  final int month;
  final int year;
  final List<String>? monthNames;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    final monthTitle =
        TWCalendarTool.getMonthName(month, monthNames: monthNames);
    final yearTitle = TWCalendarTool.getYearName(year);
    final title = yearTitle + monthTitle;
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
