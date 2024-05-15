import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:get/get.dart';

class KeepShoppingController extends GetxController with StateMixin {
  var productList = Rxn<List<Product>>();
  var averageRatingList = Rxn<List<double>>();
  var errorString = ('').obs;
  var productController = Rxn<Product>();

  final AccountApis accountApis = AccountApis();

  void keepShoppingFor() async {
    try {
      // make status to loading
      change(null, status: RxStatus.loading());

      List<Product> tempKeepShoppingForList;
      List<Product> keepShoppingForList;
      double rating;

      tempKeepShoppingForList = await accountApis.getKeepShoppingFor();

      keepShoppingForList = tempKeepShoppingForList.reversed.toList();

      for (int i = 0; i < keepShoppingForList.length; i++) {
        rating = await accountApis.getAverageRating(keepShoppingForList[i].id!);

        averageRatingList.value!.add(rating);
      }
      productList.value = keepShoppingForList;
      averageRatingList = averageRatingList;

      // if done, change status to success
      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void addToKeepShoppingFor({required Product product}) async {
    try {
      accountApis.addKeepShoppingFor(product: product);
      productController.value = product;
    } catch (e) {
      errorString.value = e.toString();
    }
  }
}
