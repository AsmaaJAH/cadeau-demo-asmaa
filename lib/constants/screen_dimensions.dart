import 'package:flutter/material.dart';

var kScreenWidth=400.0;
var kScreenHeight=800.0;

void knowScreenWidth(BuildContext context){
   kScreenWidth = MediaQuery.of(context).size.width;
}




void knowScreenHeight(BuildContext context){
 kScreenHeight = MediaQuery.of(context).size.height;
}

    // debugPrint("heeeeeerrrrrrrrrrrrreeeeeeee");
    // debugPrint(screenWidth.toString());
    // debugPrint(screenHeight.toString());