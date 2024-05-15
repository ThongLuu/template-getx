import 'package:flutter_template/controllers/cart/cart_controller.dart';
import 'package:flutter_template/controllers/cart/cart_offers_controller1.dart';
import 'package:flutter_template/controllers/cart/cart_offers_controller2.dart';
import 'package:flutter_template/controllers/cart/cart_offers_controller3.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<CartOffers1Controller>(() => CartOffers1Controller());
    Get.lazyPut<CartOffers2Controller>(() => CartOffers2Controller());
    Get.lazyPut<CartOffers3Controller>(() => CartOffers3Controller());
  }
}