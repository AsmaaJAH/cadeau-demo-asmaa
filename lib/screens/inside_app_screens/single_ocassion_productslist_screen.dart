import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/functions/APIs/show_single_ocassion.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:asmaa_demo_cadeau/widgets/inside_app/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SingleOccasionProductsListScreen extends StatefulWidget {
  const SingleOccasionProductsListScreen(
      {super.key, required this.ocassionItem});
  final Map ocassionItem;
  @override
  State<SingleOccasionProductsListScreen> createState() =>
      _SingleOccasionProductsListScreenState();
}

class _SingleOccasionProductsListScreenState
    extends State<SingleOccasionProductsListScreen> {
  final double itemWidth = kScreenWidth * 0.44;
  final double itemHeight = kScreenHeight * 0.4;
  static const _pageSize = 10;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<dynamic> newItems = await callShowSingleOcassionAPI(
          context: context,
          ocassionID: widget.ocassionItem['id'],
          pageKey: pageKey,
          pageSize: _pageSize);
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: kWhite,
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 1, color: kBlack),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            label: Row(
              children: [
                InkWell(
                  child: Image.asset("assets/images/group_2.png"),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  color: kBlack,
                  width: 2,
                  height: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Image.asset("assets/images/filter.png"),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: kWhiteSingleOcassionBorder,
              height: 2.0,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.fromLTRB(kScreenWidth * 0.15,
                kScreenHeight * 0.02, kScreenWidth * 0.15, 0),
            child: CustomizedTextWidget(
              textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kBlack,
              data: widget.ocassionItem['occasion_type']['name'],
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ]),
      body: Column(
        children: [
          SizedBox(
            width: kScreenWidth,
            height: kScreenHeight * 0.15,
            child: Image.asset("assets/images/group_13.png"
                //fit: BoxFit.cover,
                ),
          ),
          SizedBox(
            width: kScreenWidth - 20,
            height: kScreenHeight * 0.65,
            child: PagedGridView<int, dynamic>(
              pagingController: _pagingController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: itemWidth / itemHeight,
                crossAxisCount: 2,
              ),
              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                itemBuilder: (context, item, index) => ProductCard(
                  productItem: item,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
