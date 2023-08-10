import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:asmaa_demo_cadeau/screens/inside_app_screens/occasions_list_screen.dart';
import 'package:asmaa_demo_cadeau/screens/inside_app_screens/account_screen.dart';

PersistentTabController kController = PersistentTabController(initialIndex: 0);

List<Widget> _buildScreens(BuildContext context) {
  return const [
    OccasionsListScreen(),
    AccountScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 30),
          child: Icon(CupertinoIcons.gift_fill),
        ),
        iconSize: kScreenWidth * 0.085,
        title: ("Occasions"),
        activeColorPrimary: kOrange,
        inactiveColorPrimary: kBlack,

        //activeColorSecondary: kWhite,
        textStyle: const TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.w700,
          fontSize: 14,
        )),
    PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Icon(Icons.account_box_outlined),
        ),
        iconSize: kScreenWidth * 0.085,
        title: ("Account"),
        activeColorPrimary: kOrange,
        inactiveColorPrimary: kBlack,
        textStyle: const TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.w700,
          fontSize: 14,
        )),
  ];
}

class PresistTabView extends StatelessWidget {
  const PresistTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: kController,
      screens: _buildScreens(context),
      items: _navBarsItems(),
      navBarHeight: kScreenHeight * 0.1,
      confineInSafeArea: true,
      backgroundColor: kWhite,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: kWhite,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.simple,
    );
  }
}
