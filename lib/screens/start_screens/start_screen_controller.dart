import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scroll_page_view/pager/page_controller.dart';

class StartScreenController extends GetxController {
  final ScrollPageController scrollController = ScrollPageController();
  final RxInt currentIndex = 0.obs;
}
