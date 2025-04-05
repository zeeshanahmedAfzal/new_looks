import 'package:flutter/material.dart';

class ConstantButton extends StatefulWidget {
  ConstantButton(
      {required this.title,
      this.onTap,
      this.height = 48.0,
      this.color = const Color(0xFF009000),
      this.borderColor,
      this.icon,
      this.defaultPadding,
      this.textColor,
      this.firstIcon,
      this.containerPadding,
      this.radius,
      this.width,
      this.enabled = true,
      this.titleSize,
      this.containerWidth});

  final double? width;
  final double? titleSize;
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final Widget? icon;
  final Widget? firstIcon;
  final bool? defaultPadding;
  final bool? containerPadding;
  final Color? textColor;
  final double? radius;
  final bool enabled;
  final double? containerWidth;

  @override
  _ConstantButtonState createState() => _ConstantButtonState();
}

class _ConstantButtonState extends State<ConstantButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.enabled && widget.onTap != null) widget.onTap!();
      },
      child: Container(
        width: widget.containerWidth,
        padding: EdgeInsets.symmetric(
            horizontal: widget.containerPadding == true ? 30 : 0),
        height: widget.height,
        decoration: BoxDecoration(
            // color: widget.color ?? Color(0xFFA1A3AA),
            color: widget.enabled ? widget.color : Color(0xFFA1A3AA),
            borderRadius: BorderRadius.circular(widget.radius ?? 4.0),
            border: Border.all(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderColor == null ? 0.0 : 1,
            )),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.firstIcon != null) widget.firstIcon!,
              Container(
                padding: EdgeInsets.only(
                    right:
                        widget.defaultPadding == true ? widget.width ?? 14 : 0,
                    left: widget.defaultPadding == true ? 10 : 0),
                child: Text(
                  widget.title,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: widget.titleSize ?? 18.0,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor ?? Color.fromRGBO(109, 109, 109, 1),
                  ),
                ),
              ),
              if (widget.icon != null) widget.icon!,
            ],
          ),
        ),
      ),
    );
  }
}
