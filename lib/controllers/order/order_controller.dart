import 'package:flutter_template/controllers/user_controller.dart';
import 'package:flutter_template/models/user.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

class OrderController extends GetxController {
  var paymentItemList = Rxn<List<PaymentItem>>([]);
  var user = const User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: [],
      saveForLater: [],
      keepShoppingFor: [],
      wishList: []).obs;
  var errorString = ('').obs;

  var controllerUser = Get.put(UserController());

  void addPaymentItem({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemListTemp = [];

      paymentItemListTemp.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      await controllerUser.getUserData();
      user.value = controllerUser.user.value;
      paymentItemList.value = paymentItemListTemp;
    } catch (e) {
      errorString.value = e.toString();
    }
  }
}
