/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-09-04 10:52:34
 * @Description: 日期视图
 */
import 'package:flutter/material.dart';
import 'tw_calendar_configs.dart';

class TWWeekdayRow extends StatelessWidget {
  final TWCalendarWeekdayRowConfig? weekdayRowConfig;
  const TWWeekdayRow({
    Key? key,
    this.weekdayRowConfig,
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
              color: weekdayRowConfig?.titleColor ?? const Color(0XFF333333),
              fontSize: weekdayRowConfig?.titleFontSize ?? 16,
              fontWeight: FontWeight.bold,
            ),
            child: Text(
              weekDay,
            ),
          ),
        ),
      );

  List<Widget> _renderWeekDays() {
    final titles = weekdayRowConfig?.titles ??
        [
          '日',
          '一',
          '二',
          '三',
          '四',
          '五',
          '六',
        ];

    return List.generate(
        titles.length, (index) => _weekdayContainer(titles[index])).toList();
  }
}
