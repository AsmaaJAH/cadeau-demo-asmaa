import 'package:asmaa_demo_cadeau/models/ocassions.dart';
import 'package:flutter/foundation.dart';

class OcassionsState with ChangeNotifier, DiagnosticableTreeMixin {
  OcassionListResponseBody currentOcassions = OcassionListResponseBody();
  OcassionListResponseBody productsResponseBody = OcassionListResponseBody();
  List<dynamic> newOcassionsList = [];
  List<dynamic> newProducts = [];

  // var isConnecting = false;
  // var isfailed = false;

  updateNewProductsList(List<dynamic> list) {
    newProducts = list;
    notifyListeners();
  }

  updateProductsResponseBody(OcassionListResponseBody newValue) {
    productsResponseBody = newValue;
    notifyListeners();
  }

  updateNewOcassionsList(List<dynamic> list) {
    newOcassionsList = list;
    notifyListeners();
  }

  updateOcassionsResponseBody(OcassionListResponseBody newValue) {
    currentOcassions = newValue;
    notifyListeners();
  }

  // updateBoolIsConnecting(bool value) {
  //   isConnecting = value;
  //   notifyListeners();
  // }

  // updateBoolIsFailed(bool value) {
  //   isConnecting = value;
  //   notifyListeners();
  // }
}
