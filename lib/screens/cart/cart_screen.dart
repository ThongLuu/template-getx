import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/cart/cart_controller.dart';
import 'package:flutter_template/controllers/cart/cart_offers_controller1.dart';
import 'package:flutter_template/controllers/cart/cart_offers_controller2.dart';
import 'package:flutter_template/controllers/cart/cart_offers_controller3.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../../widgets/cart/add_to_card_offer.dart';
import '../../widgets/cart/amazon_pay_bannar_ad.dart';
import '../../widgets/cart/cart_icon.dart';
import '../../widgets/cart/cart_product.dart';
import '../../widgets/cart/save_for_later_single.dart';
import '../../widgets/cart/swipe_container.dart';
import '../../widgets/common_widgets/custom_app_bar.dart';
import '../../widgets/common_widgets/custom_elevated_button.dart';
import '../../widgets/common_widgets/divider_with_sizedbox.dart';
import '../../utils/constants/constants.dart';
import '../../utils/utils.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  getCartOffers(context) async {
    var controllerCartOffers1 = Get.put(CartOffers1Controller());
    var controllerCartOffers2 = Get.put(CartOffers2Controller());
    var controllerCartOffers3 = Get.put(CartOffers3Controller());

    List<String> categories = await controllerCartOffers1.setOfferCategories();
    controllerCartOffers1.cartOffers1(category: categories[0]);
    controllerCartOffers2.cartOffers2(category: categories[1]);
    controllerCartOffers3.cartOffers3(category: categories[2]);
  }

  @override
  Widget build(BuildContext context) {
    var controllerCartOffers1 = Get.put(CartOffers1Controller());
    var controllerCartOffers2 = Get.put(CartOffers2Controller());
    var controllerCartOffers3 = Get.put(CartOffers3Controller());

    var controllerCartController = Get.put(CartController());

    controllerCartController.onGetCartHandler();
    getCartOffers(context);
    // return controllerCartController.obx((state) {
    //   if (controllerCartController.errorString.value.isEmpty == false) {
    //     showSnackBar(context, controllerCartController.errorString.value);
    //   }
    return Obx(() => Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60), child: CustomAppBar()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                
                controllerCartController.total.value != null &&
                        controllerCartController.cartProducts.value != null &&
                        controllerCartController.productsQuantity.value !=
                            null &&
                        controllerCartController.averageRatingList.value !=
                            null &&
                        controllerCartController.saveForLaterProducts.value !=
                            null
                    ? Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12)
                                        .copyWith(top: 20),
                                child: controllerCartController
                                        .cartProducts.value!.isEmpty
                                    ? SizedBox(
                                        height: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                'assets/images/empty_cart.png',
                                                height: 180,
                                                width: 180,
                                              ),
                                            ),
                                            const Text(
                                                'Your Amazon Cart is empty')
                                          ],
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'SubTotal ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87),
                                              ),
                                              const Text(
                                                '₹',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                formatPriceWithDecimal(
                                                    controllerCartController
                                                        .total.value!),
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'EMI Available ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                'Details',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Constants
                                                        .selectedNavBarColor),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                color: Constants.greenColor,
                                                size: 25,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: RichText(
                                                    text: TextSpan(
                                                        text:
                                                            'Your order is eligible for FREE Delivery. ',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Constants
                                                                .greenColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                      const TextSpan(
                                                        text:
                                                            'Select this option at checkout. ',
                                                        style: TextStyle(
                                                            height: 1.4,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      TextSpan(
                                                        text: 'Details ',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Constants
                                                                .selectedNavBarColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ])),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          CustomElevatedButton(
                                            buttonText: controllerCartController
                                                        .cartProducts
                                                        .value!
                                                        .length ==
                                                    1
                                                ? 'Proceed to Buy (${controllerCartController.cartProducts.value!.length} item)'
                                                : 'Proceed to Buy (${controllerCartController.cartProducts.value!.length} items)',
                                            onPressed: () {
                                              Get.toNamed(
                                                  Routes.PAYMENTSCREENROUTE,
                                                  arguments:
                                                      controllerCartController
                                                          .total.value!);
                                            },
                                            isRectangle: true,
                                          ),
                                          const DividerWithSizedBox(
                                            thickness: 0.5,
                                            sB1Height: 20,
                                          )
                                        ],
                                      ),
                              ),
                              Visibility(
                                visible: controllerCartController
                                        .cartProducts.value !=
                                    null,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controllerCartController
                                      .cartProducts.value!.length,
                                  itemBuilder: ((context, index) {
                                    final product = controllerCartController
                                        .cartProducts.value![index];
                                    final quantity = controllerCartController
                                        .productsQuantity.value![index];

                                    return Dismissible(
                                        movementDuration:
                                            const Duration(milliseconds: 100),
                                        onDismissed:
                                            (DismissDirection direction) {
                                          if (direction ==
                                              DismissDirection.startToEnd) {
                                            controllerCartController
                                                .onDeleteFromCartHandler(
                                                    product: product);
                                            showSnackBar(context, 'Deleted!');
                                            // deleteProduct(product);
                                          } else if (direction ==
                                              DismissDirection.endToStart) {
                                            controllerCartController
                                                .onSaveForLaterHandler(
                                                    product: product);
                                            showSnackBar(
                                                context, 'Saved for later!');
                                          }
                                        },
                                        background: const SwipeContainer(
                                          isDelete: true,
                                          secondaryBackgroundText:
                                              'Save for later',
                                        ),
                                        secondaryBackground:
                                            const SwipeContainer(
                                          isDelete: false,
                                          secondaryBackgroundText:
                                              'Save for later',
                                        ),
                                        key: UniqueKey(),
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes
                                                    .PRODUCTDETAILSSCREENROUTE,
                                                arguments: {
                                                  "product": product,
                                                  "deliveryDate":
                                                      getDeliveryDate(),
                                                });
                                          },
                                          child: CartProduct(
                                            quantity: quantity,
                                            product: product,
                                          ),
                                        ));
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const DividerWithSizedBox(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CartIcon(
                                iconName: 'secure_payment.png',
                                title: 'Secure Payment',
                              ),
                              CartIcon(
                                iconName: 'delivered_alt.png',
                                title: 'Amazon Delivered',
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const AmazonPayBannarAd(),
                          const SizedBox(height: 15),
                          controllerCartController.saveForLaterProducts.value ==
                                  null
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(4),
                                      color: const Color(0xffE9EDEE),
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        controllerCartController
                                                    .saveForLaterProducts
                                                    .value!
                                                    .length ==
                                                1
                                            ? 'Saved for later (${controllerCartController.saveForLaterProducts.value!.length} item)'
                                            : 'Saved for later (${controllerCartController.saveForLaterProducts.value!.length} items)',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: controllerCartController
                                            .saveForLaterProducts.value!.length,
                                        itemBuilder: ((context, index) {
                                          final product =
                                              controllerCartController
                                                  .saveForLaterProducts
                                                  .value![index];
                                          return Dismissible(
                                            movementDuration: const Duration(
                                                milliseconds: 100),
                                            onDismissed:
                                                (DismissDirection direction) {
                                              if (direction ==
                                                  DismissDirection.startToEnd) {
                                                controller
                                                    .onDeleteFromLaterHandler(
                                                        product: product);
                                              } else if (direction ==
                                                  DismissDirection.endToStart) {
                                                controllerCartController
                                                    .onMoveToCartHandler(
                                                        product: product);
                                              }
                                            },
                                            key: UniqueKey(),
                                            background: const SwipeContainer(
                                                isDelete: true,
                                                secondaryBackgroundText:
                                                    'Move to cart'),
                                            secondaryBackground:
                                                const SwipeContainer(
                                                    isDelete: false,
                                                    secondaryBackgroundText:
                                                        'Move to cart'),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes
                                                        .PRODUCTDETAILSSCREENROUTE,
                                                    arguments: {
                                                      "product": product,
                                                      "deliveryDate":
                                                          getDeliveryDate(),
                                                    });
                                              },
                                              child: SaveForLaterSingle(
                                                product: product,
                                              ),
                                            ),
                                          );
                                        }))
                                  ],
                                ),
                          const SizedBox(height: 15),
                          controllerCartOffers1.productList.value!.isEmpty
                              ? const SizedBox()
                              : AddToCartWidget(
                                  title: 'Top picks for you',
                                  isTitleLong: false,
                                  productList:
                                      controllerCartOffers1.productList.value,
                                  averageRating: controllerCartOffers1
                                      .averageRatingList.value,
                                ),
                          controllerCartOffers2.productList.value!.isEmpty
                              ? const SizedBox()
                              : AddToCartWidget(
                                  title:
                                      'Frequently viewed with items in your cart',
                                  isTitleLong: true,
                                  productList:
                                      controllerCartOffers2.productList.value,
                                  averageRating: controllerCartOffers2
                                      .averageRatingList.value,
                                ),
                          controllerCartOffers3.productList.value!.isEmpty
                              ? const SizedBox()
                              : AddToCartWidget(
                                  title: 'Recommendations for you',
                                  isTitleLong: false,
                                  productList:
                                      controllerCartOffers3.productList.value,
                                  averageRating: controllerCartOffers3
                                      .averageRatingList.value,
                                ),
                        ],
                      )
                    : SizedBox(
                        height: MediaQuery.sizeOf(context).height - 180,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
              ],
            ),
          ),
        ));
    // },
    //     onLoading: SizedBox(
    //       height: MediaQuery.sizeOf(context).height / 1.4,
    //       child: const Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //     )
    //     );
  }
}

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget(
      {super.key,
      required this.productList,
      required this.averageRating,
      required this.title,
      required this.isTitleLong});

  final List<Product>? productList;
  final List<double>? averageRating;
  final String title;
  final bool isTitleLong;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 18),
      width: MediaQuery.sizeOf(context).height,
      color: const Color(0xffE9EDEE),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(top: 12),
        color: Colors.white,
        height: isTitleLong ? 370 : 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 290,
              child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      productList!.length > 20 ? 20 : productList!.length,
                  itemBuilder: ((context, index) {
                    Product product = productList![index];

                    return AddToCartOffer(
                      product: product,
                      averageRating: averageRating![index],
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
