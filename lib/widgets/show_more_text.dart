import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShowMoreText extends StatefulWidget {
  const ShowMoreText({
    Key? key,
    this.text,
    this.maxLength = 100,
    this.showMoreText,
    this.showLessText,
    this.style,
    this.showMoreStyle,
    this.showLessStyle,
  }) : super(key: key);

  final String? text;
  final int maxLength;
  final String? showMoreText;
  final String? showLessText;
  final TextStyle? style;
  final TextStyle? showMoreStyle;
  final TextStyle? showLessStyle;

  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool full = false;
  TapGestureRecognizer? showMoreLessGestureRecognizer;

  @override
  void initState() {
    super.initState();
    showMoreLessGestureRecognizer = TapGestureRecognizer()
      ..onTap = () => setState(() => full = !full);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text!.length <= widget.maxLength) {
      return Text(widget.text ?? "", style: widget.style);
    }

    var displayText =
    full ? widget.text : widget.text?.substring(0, widget.maxLength);
    var showTextStyle = full ? widget.showLessStyle : widget.showMoreStyle;
    var showText = full ? widget.showLessText : widget.showMoreText;

    return RichText(
      text: TextSpan(
        style: widget.style,
        children: [
          TextSpan(text: displayText),
          if (widget.text!.length > widget.maxLength) ...[
            TextSpan(text: '... '),
            TextSpan(
              text: showText,
              style: showTextStyle,
              recognizer: showMoreLessGestureRecognizer,
            ),
          ],
        ],
      ),
    );
  }
}
