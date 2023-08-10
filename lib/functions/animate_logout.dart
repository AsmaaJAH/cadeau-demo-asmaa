import 'package:asmaa_demo_cadeau/screens/login.dart';
import 'package:asmaa_demo_cadeau/screens/presist_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

//beautiful log out animation navigator push and remove stack
void animateLogout(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//--------------------------------- new rout with animations :-----------------------------------
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const LogInScreen();
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
//-----------------  predicate : remove all from stack so don't return true here ya Asmaa until I found OccasionsListScreen in stack as my home page ---------------------
    (Route route) => false,
  );
//also, clear the presist bottom navigation bar package controller
  kController = PersistentTabController(initialIndex: 0);
}
