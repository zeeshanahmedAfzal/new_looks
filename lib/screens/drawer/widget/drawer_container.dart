import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors.dart';


class DrawerContainer extends StatelessWidget {
  final String? icon;
  final double? iconSize;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final bool? showTopBorder;
  final bool? showBottomBorder;
  final Widget? iconData;
  final EdgeInsetsGeometry? edgeInsetPadding;
  final bool? isEdgeInsetPadding;
  final VoidCallback? onTap;
  
  const DrawerContainer({
    super.key,
    this.icon,
    required this.text,
    this.textStyle,
    this.padding,
    this.showTopBorder = false,
    this.showBottomBorder = false,
    this.iconSize, this.iconData, this.edgeInsetPadding = null, this.isEdgeInsetPadding = false, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: isEdgeInsetPadding == true ? EdgeInsets.symmetric(horizontal: 16) : edgeInsetPadding??EdgeInsets.zero,
        child: Column(
          children: [
            if (showTopBorder == true)
              Divider(
                height: 1,
                color: CustomColor.borderGreyOp50,
              ),
            Padding(
              padding: padding ?? EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  if(icon == null)
                    iconData ?? Icon(Icons.login_outlined,color: Color(0xff898989),),
                  // SvgPicture.asset(
                  //   icon??'',
                  //   height: iconSize ?? 20,
                  // ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          // fontFamily: Constants.FONT_DEFAULT,
                        )
                  ),
                ],
              ),
            ),
            if (showBottomBorder == true)
              Divider(
                height: 1,
                color: CustomColor.borderGreyOp50,
              ),
          ],
        ),
      ),
    );
  }
}
