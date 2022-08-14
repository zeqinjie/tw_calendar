/*
 * @Author: zhengzeqin
 * @Date: 2022-07-22 10:18:39
 * @LastEditTime: 2022-08-14 21:18:51
 * @Description: your project
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tw_calendar_example/feature/bidding_day_choice_model.dart';
import 'package:tw_calendar_example/widget/tw_horizontal_scroll_list_view.dart';
import 'package:tw_calendar_example/widget/tw_icon_button.dart';

class BiddingCalendarHeaderView extends StatelessWidget {
  final void Function(int index, BiddingDayChoiceModel model)? onTap;
  final List<BiddingDayChoiceModel>? models;
  static final double _titleHeight = 55.w;
  static final double _recommendHeight = 56.w;
  const BiddingCalendarHeaderView({
    Key? key,
    this.onTap,
    this.models,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final isHideRecommend = models?.isEmpty ?? true;
    return Container(
      height: isHideRecommend ? _titleHeight : _titleHeight + _recommendHeight,
      width: double.infinity,
      color: const Color(0XFFFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: _buildTitleView(context)),
          _buildRecommendDays(),
        ],
      ),
    );
  }

  Widget _buildTitleView(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            '選擇曝光時間',
            style: TextStyle(
              color: const Color(0XFF333333),
              fontSize: 18.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          right: 10.w,
          child: TWIconButton(
            "assets/rh_close.png",
            width: 30.w,
            height: 30.w,
            iconWidth: 24.w,
            iconHeight: 24.w,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }

  /// 推荐天数
  Widget _buildRecommendDays() {
    final isHideRecommend = models?.isEmpty ?? true;
    if (isHideRecommend) {
      return const SizedBox();
    }
    return SizedBox(
      height: _recommendHeight,
      child: TWHorizontalScrollListView(
        titleView: Padding(
          padding: EdgeInsets.only(
            left: 12.w,
            right: 8.w,
          ),
          child: Text(
            '推薦',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0XFF999999),
            ),
          ),
        ),
        itemCount: models!.length,
        maxItemCount: 5,
        itemBuilder: (contetx, i) {
          return _buildItem(i, models![i]);
        },
      ),
    );
  }

  Widget _buildItem(int index, BiddingDayChoiceModel model) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.w,
        bottom: 12.w,
        right: 8.w,
      ),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            color: model.isChoice
                ? const Color(0XFFFF8000)
                : const Color(0XFFF5F5F5),
          ),
          child: InkWell(
            highlightColor: const Color(0XFFFF8000),
            onTap: () {
              if (onTap != null) {
                onTap!(index, model);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${model.dayCount}天',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: model.isChoice
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF666666),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
