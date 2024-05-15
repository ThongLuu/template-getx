import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/keep_shopping.dart';
import 'package:get/get.dart';
import '../../widgets/common_widgets/custom_app_bar.dart';
import '../../widgets/common_widgets/single_listing_product.dart';
import '../../utils/utils.dart';

class BrowsingHistory extends GetView<KeepShoppingController> {
  const BrowsingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerKeepShoppingController = Get.put(KeepShoppingController());
    controllerKeepShoppingController.keepShoppingFor();
    return controllerKeepShoppingController.obx((state) {
      if (controllerKeepShoppingController.errorString.value.isEmpty == false) {
        showSnackBar(context, controllerKeepShoppingController.errorString.value);
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
                  'Your Browsing History',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                Column(
                  children: [
                    const Text(
                      'These items were viewed recently, We use them to personalise recommendations.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    controllerKeepShoppingController.productList.value!.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.productList.length,
                            itemBuilder: ((context, index) {
                              return SingleListingProduct(
                                  product: state.productList[index],
                                  averageRating: state.averageRatingList[index],
                                  deliveryDate: getDeliveryDate());
                            }),
                          )
                        : const Center(
                            child: Text('No products in browsing history'),
                          )
                  ],
                ),
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
