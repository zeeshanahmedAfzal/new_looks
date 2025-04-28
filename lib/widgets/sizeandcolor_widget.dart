import 'package:flutter/material.dart';

class SelectedContainer extends StatefulWidget {
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
  State<SelectedContainer> createState() => _SelectedContainerState();
}

class _SelectedContainerState extends State<SelectedContainer> {
  Set<int> selectedIndexes = {};

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  bool isSelected(int index) {
    return selectedIndexes.contains(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.grey.shade400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(widget.list.length, (index) {
              var item = widget.list[index];
              return GestureDetector(
                onTap: () => toggleSelection(index),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: isSelected(index) ? Colors.black26 : widget.isColor == true ? item : Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white),
                  ),
                  child: widget.isColor == true
                      ? (isSelected(index)
                      ? Center(
                    child: Icon(Icons.check, color: Colors.white, size: 20),
                  )
                      : null)
                      : Stack(
                    children: [
                      Center(
                        child: Text(
                          item.toString(),
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
                      Visibility(
                        visible: isSelected(index),
                        child: const Center(
                          child: Icon(Icons.check, color: Colors.black, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
