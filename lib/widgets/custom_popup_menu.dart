import 'package:flutter/material.dart';

class CustomPopUpMenu<T> extends StatelessWidget {
  // final Widget customButton;
  final List<PopupMenuEntry<T>> items;
  final Function(T value)? onSelected;
  final T? initialValue;
  final Offset offset;
  final Color menuColor;

  const CustomPopUpMenu({
    super.key,
    // required this.customButton,
    required this.items,
    this.onSelected,
    this.offset = const Offset(0, 0),
    this.menuColor = Colors.white, this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      offset: offset,
      initialValue: initialValue,
      color: menuColor,
      itemBuilder: (BuildContext context) => items,
      // child: customButton,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      splashRadius: 0,
      menuPadding: EdgeInsets.zero,
    );
  }
}
