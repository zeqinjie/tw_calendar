/*
 * @Author: zhengzeqin
 * @Date: 2022-07-16 21:37:37
 * @LastEditTime: 2022-07-22 14:14:50
 * @Description: 滚动组件封装
 */
import 'package:flutter/material.dart';

class TWHorizontalScrollListView extends StatelessWidget {
  final Widget? titleView;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder itemBuilder;

  /// item 个数
  final int itemCount;

  /// 行最大显示个数
  final int? maxItemCount;

  const TWHorizontalScrollListView({
    Key? key,
    this.titleView,
    this.padding,
    this.maxItemCount,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return titleView != null
        ? Row(
            children: [
              titleView!,
              Expanded(child: _buildBody()),
            ],
          )
        : _buildBody();
  }

  Widget _buildBody() {
    return maxItemCount != null
        ? LayoutBuilder(
            builder: (context, constraints) {
              final itemW = constraints.maxWidth / maxItemCount!;
              return _buildListView(itemW: itemW);
            },
          )
        : _buildListView();
  }

  Widget _buildListView({
    double? itemW,
  }) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      itemBuilder: itemW != null
          ? (context, index) {
              return SizedBox(
                width: itemW,
                child: itemBuilder(
                  context,
                  index,
                ),
              );
            }
          : itemBuilder,
    );
  }
}
