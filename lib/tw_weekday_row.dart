/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-21 16:17:27
 * @Description: 日期视图
 */
import 'package:flutter/material.dart';

class TWWeekdayRow extends StatelessWidget {
  const TWWeekdayRow({Key? key}) : super(key: key);

  Widget _weekdayContainer(String weekDay) => Expanded(
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
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

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _renderWeekDays(),
      );
}
