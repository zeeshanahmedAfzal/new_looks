import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_button.dart';


// class CustomEditFeedBackTextField extends StatelessWidget {
//   final String? item;
//   final Function(String data)? onEdit;
//   final String? name;
//
//   CustomEditFeedBackTextField({required this.item, this.onEdit, this.name});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<CustomTextEditingController>();
//     return Container(
//       color: const Color(0xffFFFFFF),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Obx(()=>
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           name ?? '',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           )
//                         ),
//                       ],
//                     ),
//                     if (controller.isEditing.value)
//                       Obx(()=>
//                           Stack(
//                             children: [
//                               SingleChildScrollView(
//                                 controller: controller.scrollController,
//                                 child: TextField(
//                                   autofocus: true,
//                                   controller: controller.textController,
//                                   maxLines: null, // Allows multi-line input
//                                   decoration: const InputDecoration(),
//                                   style: const TextStyle(fontSize: 16.0),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: controller.suffixOffset.value + 10,
//                                 right: 0,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     if (onEdit != null) {
//                                       onEdit!(controller.textController.text);
//                                     }
//                                     // setState(() {
//                                     controller.isEditing(false);
//                                     // });
//                                     // setState(() {
//                                     //   widget.item.feedbackText =
//                                     //       _textController.text; // Save the text
//                                     // });
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromRGBO(126, 100, 237, 1),
//                                       borderRadius: BorderRadius.circular(100),
//                                     ),
//                                     child: const Icon(
//                                       Icons.arrow_forward_rounded,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                       )
//                     else
//                       Text(
//                         item ?? '',
//                         softWrap: true,
//                         style:  TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         )
//                       ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomTextEditingController extends GetxController{
  CustomTextEditingController({required this.textFieldText});
  final String textFieldText;
  RxBool isEditing = false.obs;
  late TextEditingController textController;
  late ScrollController scrollController;

  RxDouble lineHeight = 20.0.obs; // Approximate height of a line
  RxDouble suffixOffset = 0.0.obs; // Vertical position of the suffix icon

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController(text: textFieldText);
    scrollController = ScrollController();
    textController.addListener(updateSuffixPosition);
  }

  toggleEditMode() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) suffixOffset.value = 0; // Reset offset when not editing
  }

  updateSuffixPosition() {
    final lineCount = '\n'.allMatches(textController.text).length + 1;
    suffixOffset((lineCount - 1) * lineHeight.value);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    scrollController.dispose();
  }
}


class RenameDialog extends StatelessWidget {
  const RenameDialog({super.key, this.isLoading,required this.onEdit, this.initialText, required this.title, this.widget});
  final bool? isLoading;
  final dynamic Function(String) onEdit;
  final String? initialText;
  final String title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    var controller  = Get.put(CustomTextEditingController(textFieldText: initialText??''));
    return Center(
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff000000))
            ),
            child: Material(
              color: Color(0xffffffff),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title ??"Rename Project"),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f2),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(Icons.close,size: 15,),
                        ),
                      )
                    ],
                  ),
                  Divider(color: Color(0xfff2f2f2)),
                  SizedBox(height: 10,),
                  widget ??
                  SingleChildScrollView(
                    controller: controller.scrollController,
                    child: TextField(
                      autofocus: true,
                      controller: controller.textController,
                      maxLines: null, // Allows multi-line input
                      decoration: const InputDecoration(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),

                  SizedBox(height: 20,),
                  CustomButton(
                    title: "Save",
                    radius: 5,
                    bgColor: Color(0xff4c5eff),
                    defaultPadding: true,
                    size: 16,
                    height: 30,
                    textColor: Color(0xffFFFFFF),
                    onTap: () async {
                      Get.back();
                      onEdit(controller.textController.text);
                    },
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

