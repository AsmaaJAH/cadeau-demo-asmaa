import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:asmaa_demo_cadeau/functions/APIs/get_ocassions_list.dart';
import 'package:asmaa_demo_cadeau/widgets/inside_app/ocassions/ocassion_card.dart';

class OccasionsListScreen extends StatefulWidget {
  const OccasionsListScreen({super.key});

  @override
  State<OccasionsListScreen> createState() {
    return _OccasionsListScreenState();
  }
}

class _OccasionsListScreenState extends State<OccasionsListScreen> {
  var counter = 3;
  // var isConnecting = false;
  // var isFailed = false;
  static const _pageSize = 3;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);

  void _onPress() {
    // if (counter == 0) {
    //   setState(() {
    //     counter = 3;
    //   });
    // } else if (counter != 0) {
    //   setState(() {
    //     counter = 0;
    //   });
    // }
  }

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
      final List<dynamic> newItems = await callOcassionsListGetAPI(
          context: context, pageKey: pageKey, pageSize: _pageSize);
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
    // isConnecting = context.watch<OcassionsState>().isConnecting;
    // isFailed = context.watch<OcassionsState>().isfailed;

    kOccassionConstContent = PagedListView<int, dynamic>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        itemBuilder: (context, item, index) => OcassionCard(
          item: item,
        ),
      ),
    );
    // if (!isConnecting
    //     && !isFailed
    //     && context.read<OcassionsState>().currentOcassions.extra['total_count'] == 0
    //     ) {
    //     kOccassionConstContent = const CenteredtextContent(
    //       title: 'Uh oh... No new occasions list to show right now!',
    //       text: 'It may be updated soon.Try selecting a different tab!',
    //     );
    //   }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: kWhiteBorder,
              height: 2.0,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.fromLTRB(
                kScreenWidth * 0.01, kScreenHeight * 0.02, 0, 0),
            child: const CustomizedTextWidget(
              textAlign: TextAlign.center,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: kBlack,
              data: "Occasions",
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, kScreenHeight * 0.01, kScreenWidth * 0.03, 0),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 35,
                    ),
                    onPressed: _onPress,
                  ),
                  counter != 0
                      ? Positioned(
                          right: kScreenWidth * 0.005,
                          top: kScreenHeight * 0.01,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: kOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '$counter',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ]),
      body: kOccassionConstContent,
    );
  }
}
