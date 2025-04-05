import 'package:flutter/material.dart';

class CommonSearchField extends StatefulWidget {
  const CommonSearchField(
      {this.onChanged,
      this.onClear,
      this.disableSearch = false,
      required this.hintText,
      this.txtController,
      this.onTap});

  final void Function(String)? onChanged;
  final Function? onClear;
  final Function? onTap;
  final bool disableSearch;
  final String hintText;
  final TextEditingController? txtController;

  @override
  _CommonSearchFieldState createState() => _CommonSearchFieldState();
}

class _CommonSearchFieldState extends State<CommonSearchField> {
  FocusNode _focus = FocusNode();
  late TextEditingController controller;

  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.txtController != null)
      controller = widget.txtController!;
    else
      controller = TextEditingController();
    // _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: (widget.disableSearch || widget.onTap != null)
          ? new AlwaysDisabledFocusNode()
          : null,
      controller: controller,
      textInputAction: TextInputAction.search,
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      autofocus: false,
      maxLines: 1,
      cursorColor: Color(0xffBEBFC4),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(12),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(0, 0, 0, 0.4)),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Color(0xff33302E).withOpacity(0.10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Color(0xff33302E).withOpacity(0.10),
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(
            Icons.search,
            color: Color.fromRGBO(0, 0, 0, 0.4),
            size: 21,
            weight: 1,
          ),
        ),
        // suffixIcon: controller.text.isNotEmpty
        //     ? CupertinoButton(
        //     onPressed: () {
        //       setState(() {
        //        controller.clear();
        //
        //       });
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(bottom: 8.0),
        //       child: Icon(
        //         Icons.clear,
        //         color: Color(0xFFA1A3AA),
        //       ),
        //     ))
        //     : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
