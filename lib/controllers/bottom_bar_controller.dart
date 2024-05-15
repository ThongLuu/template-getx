import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var bottomBarIndex = RxnInt(0);
  var bottomBarMoreClickedIndex = RxnInt();
  var isOpen = RxnBool();

  void onBottomBarClickedHandler(event, emit) {
    bottomBarIndex.value = event.index;
  }

  void onBotttomBarMoreClickedEvent(event, emit) {
    bottomBarMoreClickedIndex.value = event.index;
    isOpen.value = event.isOpen;
  }
}
