import 'dart:convert';

import 'package:flutter_template/models/order.dart';
import 'package:flutter_template/models/product.dart';

import '../utils/constants/strings.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

class AccountApis {
  final client = http.Client();

  Future<List<Order>> fetchMyOrders() async {
    final String token = await getToken();
    List<Order> myOrderList = [];
    try {
      http.Response res =
          await client.get(Uri.parse(fetchMyOrdersUri), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          myOrderList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return myOrderList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> searchOrders(String orderQuery) async {
    final String token = await getToken();
    try {
      http.Response res =
          await client.get(Uri.parse('$searchOrdersUri/$orderQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getProductRating(Product product) async {
    final String token = await getToken();
    try {
      http.Response res = await client
          .get(Uri.parse('$getProductRatingUri/${product.id}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> rateProduct(
      {required Product product, required double rating}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(rateProductUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            'id': product.id,
            'rating': rating,
          },
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<double> getAverageRating(String productId) async {
    final String token = await getToken();
    double averageRating = 0;

    try {
      http.Response res = await client.get(
        Uri.parse('$getAverageRatingUri/$productId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (res.statusCode == 200) {
        averageRating = jsonDecode(res.body).toDouble();

        return averageRating;
      } else {
        throw Exception(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addKeepShoppingFor({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse('$addKeepShoppingForUri/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> getKeepShoppingFor() async {
    final String token = await getToken();
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(getKeepShoppingForUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return productList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> getWishList() async {
    final String token = await getToken();
    List<Product> wishList = [];
    try {
      http.Response res = await client.get(
        Uri.parse(getWishListUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          wishList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }

        return wishList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addToWishList({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(Uri.parse(addToWishListUri),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode({
            "id": product.id,
          }));

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteFromWishList({required Product product}) async {
    final String token = await getToken();
    bool isDeleted = false;
    try {
      http.Response res = await client.delete(
        Uri.parse('$removeFromWishListUri/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (res.statusCode == 200) {
        isDeleted = true;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
      return isDeleted;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> isWishListed({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse('$isWishListedUri/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
