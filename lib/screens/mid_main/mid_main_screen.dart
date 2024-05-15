import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/midmain_controller.dart';
import 'package:flutter_template/screens/bottom_navigation_bar/bottom_bar.dart';
import 'package:flutter_template/screens/home/home_screen.dart';
import 'package:get/get.dart';

class MidMainScreen extends GetResponsiveView<MidMainController> {
  @override
  Widget builder() {
    if (screen.isPhone) {
      return renderWidget(
          iconData: Icons.phone, color: Colors.blue, text: 'Phone');
    } else if (screen.isDesktop) {
      return renderWidget(
          iconData: Icons.desktop_windows, color: Colors.red, text: 'Desktop');
    } else if (screen.isTablet) {
      return renderWidget(
          iconData: Icons.tablet, color: Colors.green, text: 'Tablet');
    } else if (screen.isWatch) {
      return renderWidget(
          iconData: Icons.watch, color: Colors.orange, text: 'Watch');
    }
    return renderWidget(
        iconData: Icons.phone, color: Colors.blue, text: 'Phone');
  }

  renderWidget(
      {required IconData iconData,
      required Color color,
      required String text}) {
    return Column(
      children: [
        const HomeScreen(),
        Container(
          height: 300,
          child: BottomBar(),
        )
      ],
    );
  }
}
