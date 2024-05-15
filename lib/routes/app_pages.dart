import 'dart:developer';

import 'package:flutter_template/bindings/bottom_bar_biding.dart';
import 'package:flutter_template/bindings/browsing_history_biding.dart';
import 'package:flutter_template/bindings/cart_biding.dart';
import 'package:flutter_template/bindings/midmain_biding.dart';
import 'package:flutter_template/screens/account/browsing_history.dart';
import 'package:flutter_template/screens/bottom_navigation_bar/bottom_bar.dart';
import 'package:flutter_template/screens/cart/cart_screen.dart';
import 'package:flutter_template/screens/mid_main/mid_main_screen.dart';

import '../bindings/home_binding.dart';
import '../bindings/login/login_binding.dart';
import '../bindings/login/login_webview_binding.dart';
import '../bindings/signup_binding.dart';
import '../middlewares/auth_middleware.dart';

import '../screens/home/home_screen.dart';
import '../screens/login/login_webview_screen.dart';
import '../screens/signup/signup_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/login/login_screen.dart';
part 'app_routes.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: Routes.MIDMAINSCREENROUTE,
        page: () => MidMainScreen(),
        binding: MidMainBinding(),
        middlewares: [AuthMiddleware()],
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.HOMESCREEN,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
        // middlewares: [AuthMiddleware()],
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
        transition: Transition.noTransition),
    // GetPage(
    //     name: Routes.LOGIN_WEBVIEW,
    //     page: () => const LoginWebviewScreen(),
    //     binding: LoginWebviewBinding(),
    //     transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP,
        page: () => const SignupScreen(),
        binding: SignupBinding(),
        transition: Transition.noTransition),
    // GetPage(
    //     name: Routes.AUTHROUTE,
    //     page: () => const SignupScreen(),
    //     binding: SignupBinding(),
    //     transition: Transition.noTransition),
    GetPage(
        name: Routes.BOTTOMBARROUTE,
        page: () => BottomBar(),
        binding: BottomBarBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.BROWSINGHISTORYSCREENROUTE,
        page: () => const BrowsingHistory(),
        binding: BrowsingHistoryBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.CARTSCREENSCREENROUTE,
        page: () => const CartScreen(),
        binding: CartBinding(),
        transition: Transition.noTransition),
  ];
}
