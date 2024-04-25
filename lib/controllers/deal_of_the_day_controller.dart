import 'package:flutter_template/models/product.dart';
import 'package:get/get.dart';

class CarouselImageController extends GetxController {
  var product = Rxn<Product>();
  var imageIndex = 0.obs;

  void setCarouselImage(product, imageIndex) {
    product = product;
    imageIndex = imageIndex;
    update();
  }
}
