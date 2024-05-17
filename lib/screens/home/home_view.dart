import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/home_view_controller.dart';
import 'package:flutter_template/screens/bottom_navigation_bar/bottom_bar.dart';
import 'package:flutter_template/screens/home/home_screen.dart';
import 'package:get/get.dart';

class HomeView extends GetResponsiveView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ResponsiveDesignThirdWay(),
    ));
  }
}

class ResponsiveDesignThirdWay extends GetResponsiveView<HomeViewController> {
  ResponsiveDesignThirdWay({super.key})
      : super(
            settings: const ResponsiveScreenSettings(
          desktopChangePoint: 800,
          tabletChangePoint: 700,
          watchChangePoint: 600,
        ));

  @override
  Widget builder() => Stack(
        children: [const HomeScreen(), BottomBar()],
      );
}
