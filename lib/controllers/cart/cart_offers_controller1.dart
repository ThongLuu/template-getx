import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:flutter_template/services/category_products_service.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../utils/constants/constants.dart';

class CartOffers1Controller extends GetxController with StateMixin {
  var productList = Rxn<List<Product>>();
  var averageRatingList = Rxn<List<double>>();
  var category1 = ('').obs;
  var category2 = ('').obs;
  var category3 = ('').obs;
  var errorString = ('').obs;

  final AccountApis accountApis = AccountApis();
  final CategoryProductsApi categoryProductsApis = CategoryProductsApi();

  Future<List<String>> setOfferCategories() async {
    List<Product> productList;

    productList = await accountApis.getKeepShoppingFor();

    if (productList.isNotEmpty && productList.length >= 3) {
      for (int i = 0; i < productList.length; i++) {
        if (category1.value == '') {
          category1.value = productList[i].category;
        } else if (category2.value == '' &&
            category1.value != '' &&
            category1.value != productList[i].category) {
          category2.value = productList[i].category;
        } else if (category3.value == '' &&
            category1.value != '' &&
            category2.value != '' &&
            category1.value != productList[i].category &&
            category2.value != productList[i].category) {
          category3.value = productList[i].category;
        }
      }
      return [category1.value, category2.value, category3.value];
    } else {
      int index = Random().nextInt(8);
      category1.value = Constants.categoryImages[index]['title']!;
      int index1 = Random().nextInt(8);
      category2.value = Constants.categoryImages[index1]['title']!;
      int index2 = Random().nextInt(8);
      category3.value = Constants.categoryImages[index2]['title']!;
      return [category1.value, category2.value, category3.value];
    }
  }

  void cartOffers1({required String category}) async {
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
