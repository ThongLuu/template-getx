import 'package:flutter_template/models/user.dart';
import 'package:flutter_template/utils/constants/strings.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class UserApiService extends ApiService {
  final client = http.Client();

  Future<http.Response> getUserData() async {
    final token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(getUserDataUri),
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
}
