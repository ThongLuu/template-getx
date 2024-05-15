import 'package:flutter_template/controllers/midmain_controller.dart';
import 'package:get/get.dart';

class MidMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MidMainController>(() => MidMainController());
  }
}