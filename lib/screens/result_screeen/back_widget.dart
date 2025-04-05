import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key, this.title, required this.isTitleVisible, this.backColor});
  final String? title;
  final Color? backColor;
  final bool isTitleVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.grey.shade300)),
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Icon(
                Icons.arrow_back_ios,
                color:backColor ??  CustomColor.black,
                size: 15,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Visibility(
          visible: isTitleVisible,
          child: Text(
            title??"",
            style: TextStyle(
                color: CustomColor.black,
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        )
      ],
    );
  }
}
