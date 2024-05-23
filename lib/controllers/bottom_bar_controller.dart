import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var bottomBarIndex = RxnInt(0);
  var bottomBarMoreClickedIndex = RxnInt();
  var isOpen = RxnBool();

  void onBottomBarClickedHandler(index) {
    bottomBarIndex.value = index;
    update();
  }

  void onBotttomBarMoreClickedEvent(index, open) {
    bottomBarMoreClickedIndex.value = index;
    isOpen.value = open;
    update();
  }
}
