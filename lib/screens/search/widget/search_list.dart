import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_popup_menu.dart';
import '../../result_screeen/result_screen.dart';
import '../search_controller.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.searchList});

  final List<SearchNameList> searchList;

  @override
  Widget build(BuildContext context) {
    return CustomPopUpMenu(
      offset: Offset(0, 40),
      items: [
        ...searchList
            .map((SearchNameList item)
        => PopupMenuItem(
          height: 35,
          padding: EdgeInsets.zero,
          value: item,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ResultScreen(title: item.name ?? ""));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.searchBorder),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name ?? "",
                          style: TextStyle(
                              color: Color(0xff000000).withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color(0xff000000).withOpacity(0.4),
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ))
            .toList(),
      ],
      onSelected: (val) async {
        // if (val is VersionDetails) {
        //   print(val.versionName);
        //   imageController.versionDetails(val);
        //   Get.back();
        //   await imageController.updateVersionData(val.id??'');
        // } else {
        //   // Handle other cases if needed
        //   print("Invalid selection type: $val");
        // }
      },
    );
  }
}

class SearchNameList {
  final String? name;

  SearchNameList({this.name});
}
