import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../model/slider_model.dart';
import 'hot_deal_banner.dart';

class HotDealBannerSlider extends StatefulWidget {
  const HotDealBannerSlider({
    Key? key,
    required this.banners,
  }) : super(key: key);

  final List<SliderModel> banners;

  @override
  State<HotDealBannerSlider> createState() => _HotDealBannerSliderState();
}

class _HotDealBannerSliderState extends State<HotDealBannerSlider> {
  final double height = 150;
  final int initialPage = 1;
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 0.8,
            initialPage: initialPage,
            // enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ),
          items: widget.banners.map((i) => HotDealBanner(banner: i)).toList(),
        ),
        const SizedBox(height: 5),
        DotsIndicator(
          dotsCount: widget.banners.length,
          key: UniqueKey(),
          decorator: DotsDecorator(
            activeColor: redColor,
            color: borderColor,
            activeSize: const Size(18.0, 4.0),
            size: const Size(18.0, 4.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
          position: _currentIndex.toDouble(),
        ),
        const SizedBox(height: 15)
      ],
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }
}
