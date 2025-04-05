import 'package:flutter/material.dart';

class SelectedContainer extends StatelessWidget {
  const SelectedContainer({
    super.key,
    required this.title,
    required this.count,
    required this.list,
    this.isColor = false,
  });

  final String title;
  final int count;
  final bool? isColor;
  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.grey.shade400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, // Space between circles
            runSpacing: 8, // Space between rows
            children: List.generate(list.length, (index) {
              var item = list[index];
              return Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: isColor == true ? item : Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white),
                ),
                child: isColor == true
                    ? null
                    : Center(
                  child: Text(
                    item ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height:10,)
        ],
      ),
    );
  }
}

class SizeAndColorList {
  final List<String>? titleList;
  final List<Color>? colorList;
  SizeAndColorList({
    this.colorList,
    this.titleList,
  });
}