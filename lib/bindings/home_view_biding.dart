import 'package:flutter_template/controllers/home_view_controller.dart';
import 'package:get/get.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewController>(
      () => HomeViewController(),
    );
  }
}