import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../routes/app_pages.dart';
import '../services/auth_api_service.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthApiService _authenticationService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    int exists = Hive.box('user').length;
    if (exists==0) {
      return RouteSettings(name: Routes.LOGIN);
    }
  }
}