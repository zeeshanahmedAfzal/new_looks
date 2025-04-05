import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  AppHeader(
      {Key? key,
      this.centerTitle = false,
      this.color,
      required this.canBack,
      this.extendedHeight,
      this.title,
      this.bottom,
      this.popAction,
      this.customTitle,
      this.actions,
      this.customLeading})
      : preferredSize =
            Size.fromHeight(kToolbarHeight + (extendedHeight == true ? 16 : 0)),
        super(key: key);
  final bool centerTitle;
  final Color? color;
  final bool canBack;
  @override
  final Size preferredSize;
  final bool? extendedHeight;
  final String? title;
  final PreferredSizeWidget? bottom;
  final VoidCallback? popAction;
  final Widget? customTitle;
  final Widget? customLeading;
  final List<Widget>? actions;
  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  var titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  getBackWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          widget.popAction != null ? widget.popAction!() : Get.back();
        },
        child: Row(
          children: [
            widget.canBack
                ? Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  )
                : SizedBox(
                    width: 8,
                  ),
            Text(widget.title == null ? "Back" : "", style: titleStyle)
          ],
        ),
      ),
    );
  }

  Widget? getTitle() {
    if (widget.customTitle != null) {
      return widget.customTitle!;
    }
    if (widget.title == null) {
      if (widget.canBack) return SizedBox.shrink();
    } else {
      return Text(widget.title ?? "", style: titleStyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: widget.centerTitle,
      backgroundColor: widget.color ?? CustomColor.white,
      shadowColor: Color(0xFFF7F7FA),
      titleSpacing: widget.canBack ? 0 : null,
      elevation: widget.extendedHeight == true ? 0 : 0.5,
      title: getTitle(),
      leadingWidth: widget.canBack ? (widget.title == null ? 120 : 50) : 30,
      leading: widget.canBack ? getBackWidget() : widget.customLeading,
      bottom: widget.bottom,
      actions: widget.actions ?? [],
    );
  }
}
