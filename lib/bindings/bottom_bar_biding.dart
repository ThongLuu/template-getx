import 'package:flutter_template/controllers/bottom_bar_controller.dart';
import 'package:flutter_template/controllers/cart/cart_controller.dart';
import 'package:flutter_template/controllers/user_controller.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<CartController>(() => CartController());
  }
}