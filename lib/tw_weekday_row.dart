/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-24 18:35:11
 * @Description: 日期视图
 */
import 'package:flutter/material.dart';
import 'package:tw_calendar/utils/tw_colors.dart';

class TWWeekdayRow extends StatelessWidget {
  final Color? color;
  final double? fontSize;
  const TWWeekdayRow({
    Key? key,
    this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _renderWeekDays(),
    );
  }

  Widget _weekdayContainer(String weekDay) => Expanded(
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              color: color ?? TWColors.tw333333,
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.bold,
            ),
            child: Text(
              weekDay,
            ),
          ),
        ),
      );

  List<Widget> _renderWeekDays() {
    List<Widget> list = [];
    list.add(_weekdayContainer("日"));
    list.add(_weekdayContainer("一"));
    list.add(_weekdayContainer("二"));
    list.add(_weekdayContainer("三"));
    list.add(_weekdayContainer("四"));
    list.add(_weekdayContainer("五"));
    list.add(_weekdayContainer("六"));
    return list;
  }
}
