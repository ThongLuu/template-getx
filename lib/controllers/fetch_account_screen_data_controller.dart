import 'dart:convert';

import 'package:flutter_template/controllers/user_controller.dart';
import 'package:flutter_template/models/order.dart';
import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/models/user.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchAccountScreenDataController extends GetxController with StateMixin {
  var ordersList = Rxn<List<Order>>();
  var keepShoppingForList = Rxn<List<Product>>();
  var wishListProducts = Rxn<List<Product>>();
  var averageRatingList = Rxn<List<double>>();
  var errorString = ('').obs;
  var emptyStringMessage = RxnString('');

  late UserController userController;
  final AccountApis accountApis = AccountApis();

  void getAccountScreenData() async {
    try {
      change(null, status: RxStatus.loading());
      List<Order> tempOrdersList;
      List<Product> keepShoppingForListTemp = [];

      tempOrdersList = await accountApis.fetchMyOrders();
      ordersList.value = tempOrdersList.reversed.toList();

      User user = await userController.getUserData();

      for (int i = 0; i < user.keepShoppingFor.length; i++) {
        keepShoppingForListTemp
            .add(Product.fromMap(user.keepShoppingFor[i]['product']));
      }
      keepShoppingForList.value= keepShoppingForListTemp.reversed.toList();

      for (int i = 0; i < user.wishList.length; i++) {
        Product product = Product.fromMap(user.wishList[i]['product']);
        wishListProducts.value!.add(product);

        double averageRating = await accountApis.getAverageRating(product.id!);
        averageRatingList.value!.add(averageRating);
      }

      if (ordersList.value!.isEmpty &&
          keepShoppingForList.value!.isEmpty &&
          wishListProducts.value!.isEmpty) {
        emptyStringMessage.value =
            'Your account is currently empty. Start adding items to your orders, wishlist, and history to see them here.';
      } else {
        ordersList = ordersList;
        keepShoppingForList = keepShoppingForList;
        wishListProducts = wishListProducts;
        averageRatingList = averageRatingList;
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }
}
