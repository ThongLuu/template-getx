import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/fetch_account_screen_data_controller.dart';
import 'package:flutter_template/routes/app_pages.dart';
import '../../widgets/account/top_buttons.dart';
import 'package:flutter_template/widgets/account/single_product.dart';
import 'package:flutter_template/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:get/get.dart';
import '../account/account_screen_app_bar.dart';
import '../../widgets/account/name_bar.dart';
import '../../utils/constants/constants.dart';
import '../../utils/utils.dart';

class AccountScreen extends GetView<FetchAccountScreenDataController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerFetchAccountScreenDataController =
        Get.put(FetchAccountScreenDataController());
    controllerFetchAccountScreenDataController.getAccountScreenData();
    return Obx(() => Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AccuntScreenAppBar(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 0,
                        child: NameBar(),
                      ),
                      Positioned(
                          top: 50,
                          child: Container(
                            height: 80,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.9)
                                  ],
                                  stops: const [
                                    0,
                                    0.45
                                  ],
                                  begin: AlignmentDirectional.topCenter,
                                  end: Alignment.bottomCenter),
                            ),
                          )),
                      Positioned(
                        top: 60,
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 200,
                            width: MediaQuery.sizeOf(context).width,
                            child: const TopButtons()),
                      ),
                    ],
                  ),
                ),

                // your orders
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child:
                        controllerFetchAccountScreenDataController
                                .errorString.value.isNotEmpty
                            ? SnackBar(
                                content: Text(
                                    controllerFetchAccountScreenDataController
                                        .errorString.value))
                            :
                        controllerFetchAccountScreenDataController
                                .emptyStringMessage.value.isNotEmpty
                            ? SizedBox(
                                height: 150,
                                child: Center(
                                  child: Text(
                                      controllerFetchAccountScreenDataController
                                          .emptyStringMessage.value),
                                ),
                              )
                            : Column(
                                children: [
                                  controllerFetchAccountScreenDataController
                                              .ordersList.value ==
                                          null
                                      ? const SizedBox()
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Your Orders',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(Routes
                                                        .YOURORDERSSCREENROUTE);
                                                  },
                                                  child: Text(
                                                    'See all',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                        color: Constants
                                                            .selectedNavBarColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 170,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      controllerFetchAccountScreenDataController
                                                          .ordersList
                                                          .value!
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .ORDERDETAILSSCREENROUTE,
                                                            arguments:
                                                                controllerFetchAccountScreenDataController
                                                                        .ordersList
                                                                        .value![
                                                                    index]);
                                                      },
                                                      child: Container(
                                                          width: 200,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12,
                                                                width: 1.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: controllerFetchAccountScreenDataController
                                                                      .ordersList
                                                                      .value![
                                                                          index]
                                                                      .products
                                                                      .length ==
                                                                  1
                                                              ? SingleProduct(
                                                                  image: controllerFetchAccountScreenDataController
                                                                      .ordersList
                                                                      .value![
                                                                          index]
                                                                      .products[
                                                                          0]
                                                                      .images[0],
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    SingleProduct(
                                                                      image: controllerFetchAccountScreenDataController
                                                                          .ordersList
                                                                          .value![
                                                                              index]
                                                                          .products[
                                                                              0]
                                                                          .images[0],
                                                                    ),
                                                                    Text(
                                                                      '+ ${controllerFetchAccountScreenDataController.ordersList.value![index].products.length - 1}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade500,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                    );
                                                  }),
                                            ),
                                            const DividerWithSizedBox(
                                              thickness: 4,
                                              sB1Height: 15,
                                              sB2Height: 0,
                                            ),
                                          ],
                                        ),

                                  // Keep Shopping For
                                  controllerFetchAccountScreenDataController
                                              .keepShoppingForList.value ==
                                          null
                                      ? const SizedBox()
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Keep shopping for',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(Routes
                                                        .BROWSINGHISTORYSCREENROUTE);
                                                  },
                                                  child: Text(
                                                    'Browsing history',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                        color: Constants
                                                            .selectedNavBarColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 15,
                                                childAspectRatio:
                                                    controllerFetchAccountScreenDataController
                                                                .keepShoppingForList
                                                                .value!
                                                                .length ==
                                                            1
                                                        ? 2.0
                                                        : controllerFetchAccountScreenDataController
                                                                    .keepShoppingForList
                                                                    .value!
                                                                    .length ==
                                                                3
                                                            ? 0.7
                                                            : 1.15,
                                                crossAxisCount: controllerFetchAccountScreenDataController
                                                            .keepShoppingForList
                                                            .value!
                                                            .length >=
                                                        4
                                                    ? 2
                                                    : controllerFetchAccountScreenDataController
                                                            .keepShoppingForList
                                                            .value!
                                                            .isEmpty
                                                        ? 1
                                                        : controllerFetchAccountScreenDataController
                                                            .keepShoppingForList
                                                            .value!
                                                            .length,
                                              ),
                                              itemCount:
                                                  controllerFetchAccountScreenDataController
                                                              .keepShoppingForList
                                                              .value!
                                                              .length >=
                                                          4
                                                      ? 4
                                                      : controllerFetchAccountScreenDataController
                                                          .keepShoppingForList
                                                          .value!
                                                          .length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes
                                                            .CATEGORYPRODUCTSSCREENROUTE,
                                                        parameters: {
                                                          "category":
                                                              controllerFetchAccountScreenDataController
                                                                  .keepShoppingForList
                                                                  .value![index]
                                                                  .category
                                                        });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 7,
                                                                horizontal: 6),
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              controllerFetchAccountScreenDataController
                                                                  .keepShoppingForList
                                                                  .value![index]
                                                                  .images[0],
                                                          height: 110,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        controllerFetchAccountScreenDataController
                                                            .keepShoppingForList
                                                            .value![index]
                                                            .category,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black87),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            const DividerWithSizedBox(
                                              thickness: 4,
                                              sB1Height: 6,
                                              sB2Height: 4,
                                            ),
                                          ],
                                        ),

                                  // Wish List
                                  controllerFetchAccountScreenDataController
                                              .wishListProducts.value ==
                                          null
                                      ? const SizedBox()
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Your Wish List',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Get.toNamed(Routes
                                                          .YOURWISHLISTSCREENROUTE);
                                                    },
                                                    child: Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color: Constants
                                                              .selectedNavBarColor),
                                                    ))
                                              ],
                                            ),
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      mainAxisSpacing: 8,
                                                      crossAxisSpacing: 15,
                                                      childAspectRatio: controllerFetchAccountScreenDataController
                                                                  .wishListProducts
                                                                  .value!
                                                                  .length ==
                                                              1
                                                          ? 2.0
                                                          : controllerFetchAccountScreenDataController
                                                                      .wishListProducts
                                                                      .value!
                                                                      .length ==
                                                                  3
                                                              ? 0.7
                                                              : 1.15,
                                                      crossAxisCount: controllerFetchAccountScreenDataController
                                                                  .wishListProducts
                                                                  .value!
                                                                  .length >=
                                                              4
                                                          ? 2
                                                          : controllerFetchAccountScreenDataController
                                                                  .wishListProducts
                                                                  .value!
                                                                  .isEmpty
                                                              ? 1
                                                              : controllerFetchAccountScreenDataController
                                                                  .wishListProducts
                                                                  .value!
                                                                  .length),
                                              itemCount:
                                                  controllerFetchAccountScreenDataController
                                                              .wishListProducts
                                                              .value!
                                                              .length >=
                                                          4
                                                      ? 4
                                                      : controllerFetchAccountScreenDataController
                                                          .wishListProducts
                                                          .value!
                                                          .length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes
                                                            .PRODUCTDETAILSSCREENROUTE,
                                                        arguments: {
                                                          "product":
                                                              controllerFetchAccountScreenDataController
                                                                  .wishListProducts
                                                                  .value![index],
                                                          "deliveryDate":
                                                              getDeliveryDate(),
                                                        });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 7,
                                                                horizontal: 6),
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              controllerFetchAccountScreenDataController
                                                                  .wishListProducts
                                                                  .value![index]
                                                                  .images[0],
                                                          height: 110,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        '  ${controllerFetchAccountScreenDataController.wishListProducts.value![index].name}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black87),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        )
                                ],
                              )),

                const SizedBox(height: 20),
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
    //     ));
  }
}

class OrdersLoadingWidget extends StatelessWidget {
  const OrdersLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12, width: 1.5),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
    );
  }
}
