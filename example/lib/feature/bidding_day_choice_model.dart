/*
 * @Author: zhengzeqin
 * @Date: 2022-07-19 09:20:17
 * @LastEditTime: 2022-08-09 11:39:38
 * @Description: your project 
 */
class BiddingDayChoiceModel {
  /// 天数
  final int dayCount;

  /// 是否选中
  bool isChoice;

  /// 自定义时间
  final bool isCustomDay;

  BiddingDayChoiceModel({
    this.dayCount = 30,
    this.isChoice = false,
    this.isCustomDay = false,
  });
}
