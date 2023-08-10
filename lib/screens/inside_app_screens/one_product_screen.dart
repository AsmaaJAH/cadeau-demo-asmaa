import 'package:asmaa_demo_cadeau/functions/APIs/get_media_list.dart';
import 'package:asmaa_demo_cadeau/functions/remove_zero_trailings.dart';
import 'package:asmaa_demo_cadeau/functions/APIs/show_one_product_api.dart';
import 'package:asmaa_demo_cadeau/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:asmaa_demo_cadeau/widgets/inside_app/products/slider_with_indicator.dart';

class OneProductScreen extends StatefulWidget {
  const OneProductScreen({super.key, required this.productItem});
  final Map productItem;

  @override
  State<OneProductScreen> createState() => _OneProductScreenState();
}

class _OneProductScreenState extends State<OneProductScreen> {
  List mediaItems = mediaList(productItem['media']);

  double rating = productItem['avg_rate'];
  int ratingsCounts = productItem['reviews_count'];
  String brandName = productItem["store"]['name'];
  String productTite = productItem['name'];
  String priceAfterDiscount = productItem['currency']['name'] +
      ' ' +
      removetrailingZeros(productItem['price_after_discount'].toString());
  String oldPrice = productItem['currency']['name'] +
      ' ' +
      removetrailingZeros(productItem['price'].toString());
  String description = productItem['description'];

  @override
  Widget build(BuildContext context) {
    debugPrint(mediaItems.toString());
    return Scaffold(
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            //cancelling the button shadow

            elevation: 0,
            heroTag: "btn1",
            onPressed: () {},
            backgroundColor: kWhite,
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 1, color: kBlack),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            label: const FloatingButton(
              width: 0,
              data: "2240 SR",
              textColor: kBlack,
              backgroundColor: kWhite,
              borderColor: kBlack,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            //cancelling the button shadow
            elevation: 0,
            heroTag: "btn2",
            backgroundColor: kTeal,
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 1, color: kTeal),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            onPressed: () {},
            label: FloatingButton(
              textColor: kWhite,
              data: "Add To Cart",
              width: kScreenWidth * 0.45,
              backgroundColor: kTeal,
              borderColor: kTeal,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: kScreenHeight * 0.9,
        //width: kScreenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      width: double.infinity,
                      height: kScreenHeight * 0.45,
                      child: SliderWithIndicator(
                        mediaItems: mediaItems,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                                color: kWhite, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: kBlack,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: kScreenWidth * 0.7,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                  color: kWhite, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.share_rounded,
                                color: kBlack,
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomizedTextWidget(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            data: "More from",
                            color: kGreySmallFont),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomizedTextWidget(
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          data: brandName,
                          color: kTeal,
                          textDecor: TextDecoration.underline,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomizedTextWidget(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      data: productTite,
                      color: kBlack,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: kYellowStars,
                            size: 18,
                          ),
                          itemCount: 5,
                          itemSize: 18.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomizedTextWidget(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            data: "$rating",
                            color: kBlack),
                        const SizedBox(
                          width: 10,
                        ),
                        const CustomizedTextWidget(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            data: "( ",
                            color: kBlack),
                        CustomizedTextWidget(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            data: "$ratingsCounts ratings",
                            textDecor: TextDecoration.underline,
                            color: kBlack),
                        const CustomizedTextWidget(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            data: " )",
                            color: kBlack),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomizedTextWidget(
                          textAlign: TextAlign.start,
                          data: priceAfterDiscount,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: kBlack,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomizedTextWidget(
                          textDecor: TextDecoration.lineThrough,
                          data: oldPrice,
                          textAlign: TextAlign.start,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: kGreyPrice,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: kWhiteBord,
                      height: 2.0,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomizedTextWidget(
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        data: "Description",
                        color: kBlack),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomizedTextWidget(
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        data: description,
                        color: kBlack),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: kWhiteBord,
                      height: 2.0,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomizedTextWidget(
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        data: "Related Products",
                        color: kBlack),
                    SizedBox(
                      height: kScreenHeight * 0.1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
