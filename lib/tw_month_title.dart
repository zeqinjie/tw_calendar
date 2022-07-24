/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-24 16:20:41
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'utils/tw_calendart_tool.dart';

class TWMonthTitle extends StatelessWidget {
  const TWMonthTitle({
    Key? key,
    required this.month,
    required this.year,
    this.monthNames,
  }) : super(key: key);

  final int month;
  final int year;
  final List<String>? monthNames;

  @override
  Widget build(BuildContext context) {
    final monthTitle =
        TWCalendarTool.getMonthName(month, monthNames: monthNames);
    final yearTitle = TWCalendarTool.getYearName(year);
    final title = yearTitle + monthTitle;
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
