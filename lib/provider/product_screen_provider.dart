import 'package:flutter/foundation.dart';

class SingleProductState with ChangeNotifier, DiagnosticableTreeMixin {
  Map productDetails = {};

  var isConnecting = false;
  var isfailed = false;

  updateProductDetails(Map newValue) {
    productDetails = newValue;
    notifyListeners();
  }

  updateBoolIsConnecting(bool value) {
    isConnecting = value;
    notifyListeners();
  }

  updateBoolIsFailed(bool value) {
    isConnecting = value;
    notifyListeners();
  }
}
