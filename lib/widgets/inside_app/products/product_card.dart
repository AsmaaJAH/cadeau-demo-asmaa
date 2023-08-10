import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/functions/remove_zero_trailings.dart';
import 'package:asmaa_demo_cadeau/functions/APIs/show_one_product_api.dart';
import 'package:asmaa_demo_cadeau/screens/inside_app_screens/one_product_screen.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productItem,
  });
  final Map productItem;
  void _showProduct(BuildContext context) async {
    final Map singleProduct = await showSingleProductDetails(
      context: context,
      productID: productItem['id'],
    );

    // ignore: use_build_context_synchronously
    if (!context.mounted) {
      return;
    }

    PersistentNavBarNavigator.pushNewScreen(context,
        screen: OneProductScreen(
          productItem: singleProduct,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = kScreenWidth * 0.44;
    final double itemHeight = kScreenHeight * 0.4;
    String capitalizedTitle = productItem['name'];
    String priceAfterDiscount = productItem['currency']['name'] +
        ' ' +
        removetrailingZeros(productItem['price_after_discount'].toString());
    String oldPrice = productItem['currency']['name'] +
        ' ' +
        removetrailingZeros(productItem['price'].toString());

    return Container(
      width: itemWidth,
      height: itemHeight * 0.9,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: () {
          _showProduct(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(productItem["image"]),
              height: itemHeight * 0.67,
              width: itemHeight * 0.67,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomizedTextWidget(
                  data: capitalizedTitle,
                  textAlign: TextAlign.start,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kBlack,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomizedTextWidget(
                      data: priceAfterDiscount,
                      textAlign: TextAlign.start,
                      fontSize: 18,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
