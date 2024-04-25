import 'dart:convert';

import 'package:flutter_template/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../services/user_api_service.dart';
import 'package:http/http.dart' as http;


class UserController extends GetxController {
  final box = GetStorage();
  final user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: [],
      saveForLater: [],
      keepShoppingFor: [],
      wishList: []).obs;

  void setUser(User user) {
    saveToStorage(user);
  }

 Future<User> getUserData() async {
    try {
      http.Response res = (await getUserData()) as http.Response;

      if (res.statusCode == 200) {
        User user = User.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );
        return user;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  void saveToStorage(User updatedUser) async {
    box.write('user_data', updatedUser.copyWith().toJson());
  }
}
