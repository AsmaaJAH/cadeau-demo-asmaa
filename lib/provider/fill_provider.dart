import 'package:flutter/foundation.dart';

class FillingState with ChangeNotifier, DiagnosticableTreeMixin {
  var isfilledPhone = false;
  var isfilledPassword = false;


  var isfilledConfirmtionPassword = false;

  var isFillingLogIn = false;
  var isFillingSetNewPass = false;


  updateBoolFilledConfirmationPassword(bool value) {
    isfilledConfirmtionPassword = value;
    
    notifyListeners();
  }

  updateBoolFilledPhone(bool value) {
    isfilledPhone = value;
    notifyListeners();
  }

  // updateBoolisFilling(bool value) {
  //   isFilling = value;
  //   notifyListeners();
  // }
    updateBoolisFillingLogIn() {
    isFillingLogIn = isfilledPhone && isfilledPassword;
    notifyListeners();
  }
    updateBoolisFillingSetNewPass() {
    isFillingSetNewPass = isfilledPassword && isfilledConfirmtionPassword;
    notifyListeners();
  }

  updateBoolFilledPassword(bool value) {
    isfilledPassword = value;
    notifyListeners();
  }

  /// Makes `FillingState` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(bool('isfilledPhone', isfilledPhone));
    // properties.add(bool('isfilledPassword', isfilledPassword));
  }
}
