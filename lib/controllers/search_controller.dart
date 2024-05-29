import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:flutter_template/services/product_service.dart';
import 'package:get/get.dart';

class SearchQueryController extends GetxController with StateMixin {
  var searchProducts = Rxn<List<Product>>([]);
  var averageRatingList = Rxn<List<double>>();
  var errorString = ('').obs;

  ProductsApis productApis = ProductsApis();
  AccountApis accountApis = AccountApis();

  void searchEventHandler(event, emit) async {
    try {
      change(null, status: RxStatus.loading());
      List<Product> searchProductsTemp;
      List<double> averageRatingListTemp = [];
      double rating;

      searchProductsTemp = await productApis.searchProducts(event.searchQuery);

      for (int i = 0; i < searchProductsTemp.length; i++) {
        rating = await accountApis.getAverageRating(searchProductsTemp[i].id!);
        averageRatingListTemp.add(rating);
      }

      searchProducts.value = searchProductsTemp;
      averageRatingList.value = averageRatingListTemp;
      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }
}
