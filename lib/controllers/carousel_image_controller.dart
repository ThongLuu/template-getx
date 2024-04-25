import 'package:get/get.dart';

class CarouselImageController extends GetxController {
  var indexCarouselImage = 0.obs;

  // void setCarouselImage(RxInt index) {
  //   indexCarouselImage = index;
  //   print("The clicked index is $index");
  //   update();
  // }

  void resetCarouselImage(){
    indexCarouselImage = 0.obs;
  }
}
