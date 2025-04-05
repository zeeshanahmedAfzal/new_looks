import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
      {required this.title,
        this.onTap,
        this.height = 48.0,
        this.width,
        this.color = const Color(0xFF009000),
        this.borderColor,
        // this.isEnabled = false,
        this.icon,
        this.icon2,
        this.defaultPadding,
        this.radius,
        this.size,
        this.border,
        this.isOutlined = false,
        this.textColor,
        this.sizeheight,
        this.sizewidth,
        this.leftPad,
        this.fontFamily,
        this.fontWeight,
        this.bgColor,
        this.isLoading = false,
        this.isSuffixBtn = false,
        this.suffixIcon, this.constraintsContMinWidth, this.constraintsContMaxWidth,
        this.isConstraintsApplied = false, this.horizontalPadding, this.textAlign, this.loaderColor, this.loaderHeight, this.loaderWidth, this.mainAxisAlignment});
  final double? constraintsContMinWidth;
  final double? constraintsContMaxWidth;
  final bool isConstraintsApplied;
  final String? fontFamily;
  final double? horizontalPadding;
  final Color? loaderColor;
  final bool isOutlined;
  final double? width;
  final String title;
  final Color? border;
  final double? radius;
  final VoidCallback? onTap;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? size;
  final Color? borderColor;
  final Widget? icon;
  final Widget? icon2;
  final bool? defaultPadding;
  final double? sizewidth;
  final double? sizeheight;
  final double? leftPad;
  final FontWeight? fontWeight;
  final Color? bgColor;
  final bool isLoading;
  final bool isSuffixBtn;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final double? loaderHeight;
  final double? loaderWidth;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.only(left: widget.leftPad ?? 0),
          child: Container(
            height: widget.height,
            width: widget.width,
            constraints:widget.isConstraintsApplied ?
            BoxConstraints(minWidth: widget.constraintsContMinWidth??0, maxWidth: widget.constraintsContMaxWidth??0):
            null,
            padding: EdgeInsets.symmetric(horizontal: widget.isSuffixBtn ? 10 : 4),
            decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(widget.radius ?? 10),
                border: Border.all(
                  color: widget.borderColor ?? Colors.transparent,
                  width: widget.borderColor == null ? 0.0 : 1,
                )),
            child: widget.isLoading
                ? Center(
              child: SizedBox(
                height: widget.loaderHeight ?? 30,
                width: widget.loaderWidth ?? 30,
                child: CircularProgressIndicator(
                    color: widget.loaderColor ?? Colors.white),
              ),
            )
                : widget.isSuffixBtn == false ?  Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) widget.icon!,
                    Visibility(
                        visible: widget.title.isNotEmpty,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                widget.defaultPadding == true
                                    ? widget.horizontalPadding ?? 16
                                    : 0),
                            child: Text(
                              widget.title,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: widget.textAlign ??  TextAlign.center,
                              style: TextStyle(
                                fontSize: widget.size ?? 18,
                                fontWeight: widget.fontWeight ??
                                    FontWeight.w600,
                                color: widget.textColor,
                              ),
                            ))
                    ),
                    if(widget.icon2 != null) widget.icon2!
                  ],
                ),
              ),
            )
                :Row(
              mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  textAlign: widget.textAlign ?? TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.size ?? 18,
                    fontWeight: widget.fontWeight ??
                        FontWeight.w600,
                    color: widget.textColor,
                  ),
                  // style: TextStyle(
                  //   fontWeight: FontWeight.w600,
                  //   color: widget.textColor ?? Colors.black,
                  // ),
                ),
                if (widget.suffixIcon != null)
                  widget.suffixIcon!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
