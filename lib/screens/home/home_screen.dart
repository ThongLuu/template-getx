import 'package:flutter/material.dart';
// import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/four-images-offer/admin_four_image_offer_cubit.dart';

import 'package:flutter_template/controllers/carousel_image_controller.dart';
import 'package:flutter_template/controllers/home_controller.dart';
import 'package:flutter_template/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../../widgets/common_widgets/custom_app_bar.dart';
import '../../widgets/home/address_bar.dart';
import '../../widgets/home/carousel_image.dart';
import '../../widgets/home/deal_of_the_day.dart';
import '../../widgets/home/multi_image_offer.dart';
import '../../widgets/home/top_categories.dart';
import '../../utils/constants/constants.dart';
import '../../utils/utils.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerCarouselImage = Get.put(CarouselImageController());
    var controllerUser = Get.put(UserController());
    controllerCarouselImage.resetCarouselImage();
    // context
    //     .read<AdminFourImageOfferCubit>()
    //     .adminGetFourImagesOffer(isUser: true);

    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (controllerUser.user.value.address == '')
                const SizedBox()
              else
                const AddressBar(),
              const TopCategories(),
              CarouselImage(),
              Container(
                decoration:
                    const BoxDecoration(gradient: Constants.goldenGradient),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const DealOfTheDay(),
                      const SizedBox.square(dimension: 8),
                      // BlocConsumer<AdminFourImageOfferCubit,
                      //     AdminFourImageOfferState>(
                      //   listener: (context, state) {
                      //     if (state is AdminFourImageOfferErrorS) {
                      //       showSnackBar(context, state.errorString);
                      //     }
                      //   },
                      //   builder: (context, state) {
                      //     if (state is AdminGetFourImageOfferSuccessS) {
                      //     return ListView.builder(
                      //         shrinkWrap: true,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //         itemCount: state.fourImagesOfferList.length,
                      //         itemBuilder: ((context, index) {
                      //           final offer = state.fourImagesOfferList[index];

                      //           return MultiImageOffer(
                      //             title: offer.title,
                      //             category: offer.category,
                      //             images: offer.images,
                      //             labels: offer.labels,
                      //           );
                      //         }));
                      //     } else {
                      //       context
                      //           .read<AdminFourImageOfferCubit>()
                      //           .adminGetFourImagesOffer(isUser: true);
                      //       return SizedBox(
                      //         height: MediaQuery.sizeOf(context).height / 1.2,
                      //         child: const Center(
                      //           child: CircularProgressIndicator(),
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
