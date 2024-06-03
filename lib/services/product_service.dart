import 'package:flutter_template/models/product.dart';
import 'dart:convert';

import '../../utils/utils.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/strings.dart';

class ProductsApis {
  final client = http.Client();

  Future<List<Product>> searchProducts(String keySearch) async {
    String token = await getToken();
    List<Product> productList = [];

    try {
      http.Response res = await client.get(
          Uri.parse('https://dummyjson.com/products/search?q=$keySearch'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // 'x-auth-token': token,
          });

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)['products'].length; i++) {
          productList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)['products'][i],
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

  Future<int> getAverageRatingLength({required String productId}) async {
    String token = await getToken();

    try {
      http.Response res = await client
          .get(Uri.parse('$getAverageRatingLengthUri/$productId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      if (res.statusCode == 200) {
        int getAverageRatingLength = jsonDecode(res.body);

        return getAverageRatingLength;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Product> getDealOfTheDay() async {
    String token = await getToken();
    try {
      Product product;
      http.Response res =
          await client.get(Uri.parse(getDealOfTheDayUri), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      if (res.statusCode == 200) {
        product = Product.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );

        return product;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
