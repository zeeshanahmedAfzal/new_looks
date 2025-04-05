import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(
      {super.key,
      required this.title,
      required this.viewTitle,
      required this.widget});

  final String title;
  final String viewTitle;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: CustomColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              Text(
                viewTitle,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff9B9B9B),
                    color: Color(0xff9B9B9B),
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        widget
      ],
    );
  }
}
