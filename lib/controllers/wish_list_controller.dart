import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:flutter_template/services/user_service.dart';
import 'package:get/get.dart';

class WishListController extends GetxController with StateMixin {
  var wishList = Rxn<List<Product>>([]);
  var averageRatingList = Rxn<List<double>>();
  var getWishListErrorS = ('').obs;
  var wishListErrorS = ('').obs;
  var productAddedToWishListS = Rxn<Product>();
  var productNotAddedToWishListS = Rxn<Product>();
  var productDeletedFromWishListS = Rxn<Product>();
  var productWishListErrorS = Rxn<Product>();

  final AccountApis accountApis = AccountApis();
  final UserApi userApis = UserApi();

  void getWishList() async {
    try {
      change(null, status: RxStatus.loading());

      wishList.value = await accountApis.getWishList();

      for (int i = 0; i < wishList.value!.length; i++) {
        double averageRating =
            await accountApis.getAverageRating(wishList.value![i].id!);
        averageRatingList.value!.add(averageRating);
      }
      wishList = wishList;
      averageRatingList = averageRatingList;

      change(null, status: RxStatus.success());
    } catch (e) {
      getWishListErrorS.value = e.toString();
    }
  }

  void isWishList({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());

      bool isWishListed = await accountApis.isWishListed(product: product);

      if (isWishListed) {
        productAddedToWishListS.value = product;
      } else {
        productNotAddedToWishListS.value = product;
      }

      change(null, status: RxStatus.success());
    } catch (e) {
      getWishListErrorS.value = e.toString();
    }
  }

  Future<void> addToWishList({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());
      accountApis.addToWishList(product: product);

      productAddedToWishListS.value = product;
      change(null, status: RxStatus.success());
    } catch (e) {
      wishListErrorS.value = e.toString();
    }
  }

  void deleteFromWishList({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());
      accountApis.deleteFromWishList(product: product);

      productDeletedFromWishListS.value = product;
      change(null, status: RxStatus.success());
    } catch (e) {
      wishListErrorS.value = e.toString();
    }
  }

// Wish list screen

  void removedFromWishListScreen({required Product product}) async {
    try {
      List<Product> productList;
      List<double> averageRatings = [];

      change(null, status: RxStatus.loading());

      bool isDeleted = await accountApis.deleteFromWishList(product: product);

      if (isDeleted) {
        productList = await accountApis.getWishList();

        for (int i = 0; i < productList.length; i++) {
          double averageRating =
              await accountApis.getAverageRating(productList[i].id!);
          averageRatings.add(averageRating);
        }
        wishList.value = productList;
        averageRatingList.value = averageRatings;
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      getWishListErrorS.value = e.toString();
    }
  }

// Add to cart from wishlist

  void addToCartFromWishList({required Product product}) async {
    try {
      List<Product> wishListTemp;
      List<double> averageRatings = [];

      change(null, status: RxStatus.loading());

      wishListTemp = await userApis.addToCartFromWishList(product: product);
      if (wishListTemp.isNotEmpty) {
        for (int i = 0; i < wishListTemp.length; i++) {
          double averageRating =
              await accountApis.getAverageRating(wishListTemp[i].id!);
          averageRatings.add(averageRating);
        }

        wishList.value = wishListTemp;
        averageRatingList.value = averageRatings;
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      getWishListErrorS.value = e.toString();
    }
  }
}
