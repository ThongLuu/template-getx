import 'dart:convert';

import 'package:flutter_template/models/user.dart';
import 'package:flutter_template/services/user_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class UserController extends GetxController {
  final UserApi userApi = UserApi();
  final box = GetStorage();
  final user = const User(
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
      http.Response res = await userApi.getUserData();

      if (res.statusCode == 200) {
        User userFetch = User.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );
        saveToStorage(userFetch);
        user.value = userFetch;
        return userFetch;
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
