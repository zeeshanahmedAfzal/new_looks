import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/search/widget/search_list.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/search_bar_text_field.dart';
import '../product_details/porduct_detail_screen.dart';
import '../result_screeen/result_screen.dart';
import 'search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SearchedController());
    controller.onInit();
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppHeader(
          customTitle: Center(child: Text("Discover")),
          canBack: false,
          // customLeading: Padding(
          //     padding: const EdgeInsets.only(left: 16),
          //     child: Image.asset(
          //       AssetUtils.Menu,
          //       height: 18,
          //       width: 18,
          //     )),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 16),
          //     child: Icon(Icons.notifications),
          //   )
          // ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 21,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CommonSearchField(
                        hintText: 'Search',
                        onTap: (){
                          print("object");
                          SearchList(searchList: controller.searchList);
                        },
                        txtController: controller.searchText,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color(0xff33302E).withOpacity(0.10)),
                    ),
                    height: 46,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.asset(
                        AssetUtils.Filter_Icon,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx((){
                if(controller.allProducts.isNotEmpty){
                  return ResultGrid(products: controller.allProducts);
                }else{
                  return Text("no data at all");
                }
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}

