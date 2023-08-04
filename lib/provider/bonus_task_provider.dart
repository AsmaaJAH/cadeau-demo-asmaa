import 'package:flutter/foundation.dart';

class BonusCheckerState with ChangeNotifier, DiagnosticableTreeMixin {
  var isLengthChecked = false;
  var isContentChecked = false;

  updateBoolLengthChecked(bool value) {
    isLengthChecked = value;
    notifyListeners();
  }

  updateBoolContentChecked(bool value) {
    isContentChecked = value;
    notifyListeners();
  }

  /// Makes `CheckerState` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(bool('isfilledPhone', isfilledPhone));
    // properties.add(bool('isfilledPassword', isfilledPassword));
  }
}
