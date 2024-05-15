import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/wish_list_controller.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../../widgets/account/single_wish_list_product.dart';
import '../../widgets/common_widgets/custom_app_bar.dart';
import '../../utils/utils.dart';

class WishListScreen extends GetView<WishListController> {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerWishListController = Get.put(WishListController());

    return controllerWishListController.obx((state) {
      if (controllerWishListController.getWishListErrorS.value.isEmpty == false) {
        showSnackBar(context, controllerWishListController.getWishListErrorS.value);
      }
      return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Wish List',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 0.867)),
                ),
                const SizedBox(height: 10),
                controllerWishListController.wishList.value!.isNotEmpty &&
                        controllerWishListController.averageRatingList.value!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.wishList.length,
                        itemBuilder: ((context, index) {
                          Product product = state.wishList[index];
                          double averageRating = state.averageRatingList[index];

                          // return SingleWishListProduct(
                          //   product: product,
                          //   deliveryDate: getDeliveryDate(),
                          //   averageRating: averageRating,
                          // );
                        }))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      );
    },
        onLoading: SizedBox(
          height: MediaQuery.sizeOf(context).height / 1.4,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
