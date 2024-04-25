import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/constants.dart';
import 'package:flutter_template/controllers/carousel_image_controller.dart';
import 'package:get/get.dart';

import 'bottom_offers.dart';
import 'custom_carousel_slider.dart';
import 'dots_indicator.dart';

class CarouselImage extends GetView<CarouselImageController> {
  CarouselImage({super.key});

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselImageWidget(
      controller: _controller,
      index: controller.indexCarouselImage.value,
    );
  }
}

class CarouselImageWidget extends GetView<CarouselImageController> {
  const CarouselImageWidget({
    super.key,
    required CarouselController controller,
    required this.index,
  }) : _controller = controller;

  final CarouselController _controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCarouselSliderMap(
            sliderImages: Constants.carouselImages,
            onPageChanged: (index, reason) {
              controller.indexCarouselImage.value = index;
            }),
        Positioned(
          top: 245,
          left: MediaQuery.sizeOf(context).width / 3.3,
          child: DotsIndicatorMap(
            controller: _controller,
            current: index,
            sliderImages: Constants.carouselImages,
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              height: 180,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.95),
                    Colors.white,
                  ],
                  stops: const [0, 0.1, 0.4, 0.6],
                ),
              ),
            )),
        const Positioned(
          bottom: 0,
          child: BottomOffers(),
        ),
      ],
    );
  }
}
