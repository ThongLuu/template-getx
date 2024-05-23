import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:flutter_template/services/category_products_service.dart';
import 'package:get/get.dart';

class CartOffers2Controller extends GetxController with StateMixin {
  var productList = Rxn<List<Product>>([]);
  var averageRatingList = Rxn<List<double>>();
  var errorString = ('').obs;

  final AccountApis accountApis = AccountApis();
  final CategoryProductsApi categoryProductsApis = CategoryProductsApi();

  void cartOffers2({required String category}) async {
    try {
      List<Product> productListTemp;
      List<double> averageRatingListTemp = [];
      double rating = 0;

      productListTemp = await categoryProductsApis.fetchCategoryProducts(category);
      productListTemp.shuffle();

      for (int i = 0; i < productListTemp.length; i++) {
        rating = await accountApis.getAverageRating(productListTemp[i].id!);
        averageRatingListTemp.add(rating);
      }

      productList.value = productListTemp;
      averageRatingList.value = averageRatingListTemp;
    } catch (e) {
      errorString.value = e.toString();
    }
  }
}
