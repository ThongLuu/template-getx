import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/search_controller.dart';
import 'package:flutter_template/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../../../widgets/common_widgets/custom_app_bar.dart';
import '../../../widgets/common_widgets/single_listing_product.dart';
import '../../../widgets/home/address_bar.dart';
import '../../../utils/utils.dart';

class SearchScreen extends GetView<SearchQueryController> {
  const SearchScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    var controllerUser = Get.put(UserController());
    controller.searchEventHandler(searchQuery);
    return Obx(() => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(),
        ),
        body:
            // BlocConsumer<SearchBloc, SearchState>(
            //   listener: (context, state) {
            //     if (state is SearchErrorS) {
            //       showSnackBar(context, state.errorString);
            //     }
            //   },
            // builder: (context, state) {
            // if (state is SearchLoadingS) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else if (state is SearchSuccessS) {
            controller.searchProducts.value!.isNotEmpty &&
                    controller.averageRatingList.value!.isNotEmpty
                ? Column(
                    children: [
                      controllerUser.user.value.address == ''
                          ? const SizedBox()
                          : const AddressBar(),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.searchProducts.value!.length,
                          itemBuilder: ((context, index) {
                            final product =
                                controller.searchProducts.value![index];
                            final averageRating =
                                controller.averageRatingList.value![index];

                            return SingleListingProduct(
                              product: product,
                              averageRating: averageRating,
                              deliveryDate: getDeliveryDate(),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                : const SizedBox()));
  }
}
