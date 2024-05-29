import 'package:equatable/equatable.dart';
import 'package:flutter_template/controllers/user_controller.dart';
import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/models/user.dart';
import 'package:flutter_template/services/user_service.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

class PlaceOrderBuyNowGetxController extends GetxController {
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
  var PlaceOrderBuyNowDisable = RxnBool(false);

  var controllerUser = Get.put(UserController());
  final UserApi userApi = UserApi();

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

  void gPayButton({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemListTemp = [];

      paymentItemListTemp.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      await controllerUser.getUserData();
      user.value = controllerUser.user.value;

      if (controllerUser.user.value.address == '') {
        PlaceOrderBuyNowDisable.value = true;
      } else {
        user.value = controllerUser.user.value;
        paymentItemList.value = paymentItemListTemp;
      }
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void placeOrderBuyNow(
      {required Product product, required String address}) async {
    try {
      await userApi.placeOrderBuyNow(product: product, address: address);
    } catch (e) {
      errorString.value = e.toString();
    }
  }
}
