import 'package:get/get.dart';
import 'package:flutter_template/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchQueryController>(() => SearchQueryController());
  }
}
