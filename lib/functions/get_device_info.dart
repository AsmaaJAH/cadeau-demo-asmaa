import 'dart:io';
import 'package:devicelocale/devicelocale.dart';

var kDeviceType = "unknown";
var kTimeZone = 'Cairo';
var kMostFavouriteUserLanguage = 'en';

void determineDeviceType() {
  //------------------------------ device type------------------------
  //"android" , "ios" , "web", "unknown"
  if (Platform.isAndroid) {
    kDeviceType = "android";
  } else if (Platform.isIOS) {
    kDeviceType = "ios";
  } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    kDeviceType = "web";
  } else {
    kDeviceType = "unknown";
  }
}

void determineTimeZone() {
  //------------------- time zone ------------------------------------------
  kTimeZone = DateTime.now().timeZoneName.toString();
  //debugPrint(timeZone+"timeZone");
}

void determineLanguage() async {
  List? languagesList;
  //-------------------- language ------------------------------------------
  languagesList = await Devicelocale.preferredLanguages;
  // debugPrint("myyyyyyyyyyyyyyyyyy       listttttttttttttttttttttttttttt");
  // debugPrint(_languagesList.toString());
  kMostFavouriteUserLanguage =
      languagesList!.asMap()[0].toString().split('-')[0].toString();
}


