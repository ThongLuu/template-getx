import 'package:flutter_template/models/product.dart';
import 'dart:convert';

import '../../utils/utils.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/strings.dart';

class CategoryProductsApi {
  final client = http.Client();

  Future<List<Product>> fetchCategoryProducts(String category) async {
    String token = await getToken();
    List<Product> productList = [];

    try {
      http.Response res = await client
          .get(Uri.parse('$fetchCategoryProductsUri$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

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
}
