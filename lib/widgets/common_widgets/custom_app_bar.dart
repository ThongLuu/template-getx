import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:get/get.dart';
// import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import '../../widgets/common_widgets/search_text_form_field.dart';
import '../../utils/constants/constants.dart';
// import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: Constants.appBarGradient),
      ),
      title: SearchTextFormField(onTapSearchField: (String query) {
        Get.toNamed(Routes.SEARCHSCREENROUTE,
            parameters: {'searchQuery': query});
      }),
    );
  }
}
