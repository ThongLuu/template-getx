import 'package:flutter_template/models/product.dart';
import 'package:flutter_template/services/account_service.dart';
import 'package:flutter_template/services/user_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController with StateMixin {
  var cartProducts = Rxn<List<Product>>();
  var saveForLaterProducts = Rxn<List<Product>>();
  var averageRatingList = Rxn<List<double>>();
  var productsQuantity = Rxn<List<int>>();
  var total = Rxn<double>();

  var errorString = ('').obs;

  var addToCartFromBottomSheet = Rxn<Product>();
  var removeFromCart = Rxn<Product>();
  var saveForLaterE = Rxn<Product>();
  var deleteFromLaterE = Rxn<Product>();
  var moveToCartE = Rxn<Product>();

  final AccountApis accountApis = AccountApis();
  final UserApi userApis = UserApi();

  Future<List<dynamic>> tryBlockCode(
      {required dynamic customUserRepository}) async {
    List<List> items;
    List<Product> cartProducts;
    List<Product> saveForLaterProducts;
    List<int> productsQuantity;
    List<double> averageRatingList = [];
    double rating;
    double sum = 0;

    items = await customUserRepository;
    cartProducts = items[0] as List<Product>;
    productsQuantity = items[1] as List<int>;

    saveForLaterProducts = await userApis.getSaveForLater();

    for (int i = 0; i < cartProducts.length; i++) {
      sum += cartProducts[i].price * productsQuantity[i];

      rating = await accountApis.getAverageRating(cartProducts[i].id!);

      averageRatingList.add(rating);
    }

    return [
      sum,
      cartProducts,
      averageRatingList,
      productsQuantity,
      saveForLaterProducts
    ];
  }

  void onGetCartHandler() async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items =
          await tryBlockCode(customUserRepository: await userApis.getCart());

      total.value = items[0];
      cartProducts.value = items[1];
      averageRatingList.value = items[2];
      productsQuantity.value = items[3];
      saveForLaterProducts.value = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onAddToCartHandler(event, emit) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userApis.addToCart(product: event.product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onAddToCartFromBottomSheetHandler(event, emit) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userApis.addToCart(product: event.product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onRemoveFromCartHandler(event, emit) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userApis.removeFromCart(product: event.product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onDeleteFromCartHandler({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userApis.deleteFromCart(product: product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onSaveForLaterHandler({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository: await userApis.saveForLater(product: product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onDeleteFromLaterHandler({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userApis.deleteFromLater(product: product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  void onMoveToCartHandler({required Product product}) async {
    try {
      change(null, status: RxStatus.loading());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userApis.moveToCart(product: product));

      total = items[0];
      cartProducts = items[1];
      averageRatingList = items[2];
      productsQuantity = items[3];
      saveForLaterProducts = items[4];

      change(null, status: RxStatus.success());
    } catch (e) {
      errorString.value = e.toString();
    }
  }

  int get cartItemsLength {
    if (cartProducts.value!.isNotEmpty) {
      return cartProducts.value!.length;
    } else {
      return -1;
    }
  }
}
