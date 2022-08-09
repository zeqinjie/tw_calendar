/*
 * @Author: zhengzeqin
 * @Date: 2022-08-09 11:38:07
 * @LastEditTime: 2022-08-09 11:38:12
 * @Description: your project
 */
import 'package:flutter/material.dart';

class TWIconButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? event;
  final double? width;
  final double? height;
  final double? iconWidth;
  final double? iconHeight;
  final String icon;
  final BoxFit fit;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const TWIconButton(
    this.icon, {
    Key? key,
    this.event,
    this.width,
    this.height,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.iconColor,
    this.fit = BoxFit.fitHeight,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Image.asset(
          icon,
          fit: fit,
          height: iconHeight ?? height,
          width: iconWidth ?? width,
          color: iconColor,
        ),
      ),
    );
  }
}
