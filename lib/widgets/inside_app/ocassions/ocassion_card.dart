import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/screens/inside_app_screens/single_ocassion_productslist_screen.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:transparent_image/transparent_image.dart';

class OcassionCard extends StatelessWidget {
  const OcassionCard({
    super.key,
    required this.item,
  });
  final Map item;

  String transformToCapitalTitle(String title) {
    return title.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    String capitalizedTitle = transformToCapitalTitle(item['name']);
    String description = item['occasion_type']['description'];

    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(item["occasion_type"]["banner"]),
            fit: BoxFit.cover,
            height: kScreenHeight * 0.33,
            width: double.infinity,
          ),
          Container(
            height: kScreenHeight * 0.33,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kBlack,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: kLinearGradientColorsList,
              ),
            ),
          ),
          Positioned(
            top: kScreenHeight * 0.09,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: kScreenWidth * 0.1,
                        height: kScreenWidth * 0.1,
                        child: Image.network(
                          item["occasion_type"]["icon"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomizedTextWidget(
                        data: capitalizedTitle,
                        textAlign: TextAlign.center,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: kWhiteTitle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: kScreenWidth * 0.4,
                        child: CustomizedTextWidget(
                          data: description,
                          textAlign: TextAlign.start,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kWhiteTitle,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(25, 25, 10, 0),
                        height: 35,
                        width: kScreenWidth * 0.329,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.fromLTRB(35, 0, 35, 0),
                                ),
                                backgroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                        kOrange)),
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: SingleOccasionProductsListScreen(
                                      ocassionItem: item));
                            },
                            child: const CustomizedTextWidget(
                              data: "View",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: kWhiteTitle,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
