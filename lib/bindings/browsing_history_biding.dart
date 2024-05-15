import 'package:flutter_template/controllers/keep_shopping.dart';
import 'package:get/get.dart';

class BrowsingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeepShoppingController>(() => KeepShoppingController());
  }
}