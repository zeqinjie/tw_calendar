/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-21 16:17:44
 * @Description: your project
 */
import 'package:flutter/cupertino.dart';

class TWCalendarNotification extends Notification {
  TWCalendarNotification(this.selectDay);

  final int selectDay;
}
