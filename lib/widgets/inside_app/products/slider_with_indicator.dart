import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';

class SliderWithIndicator extends StatefulWidget {
  const SliderWithIndicator({super.key, required this.mediaItems});
  final List mediaItems;

  @override
  State<SliderWithIndicator> createState() => _SliderWithIndicatorState();
}

class _SliderWithIndicatorState extends State<SliderWithIndicator> {
  int currentActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 11.5 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlayInterval: const Duration(milliseconds: 1800),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            height: kScreenHeight * 0.4,
            onPageChanged: (index, reason) {
              setState(() {
                currentActiveIndex = index;
              });
            },
          ),
          items: widget.mediaItems.map((imageURL) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: kScreenWidth,
                  height: kScreenHeight * 0.4,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: kWhite),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(imageURL),
                    fit: BoxFit.fill,
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 15,
        ),
        AnimatedSmoothIndicator(
          activeIndex: currentActiveIndex,
          count: widget.mediaItems.length,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: 32,
              color: kOrange,
              borderRadius: BorderRadius.circular(0),
            ),
            dotDecoration: DotDecoration(
              width: 32,
              color: kGreySliderIndicator,
              borderRadius: BorderRadius.circular(0),
              verticalOffset: 0,
            ),
            spacing: 10.0,
          ),
        )
      ],
    );
  }
}
