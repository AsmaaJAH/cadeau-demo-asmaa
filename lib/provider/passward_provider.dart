import 'package:flutter/foundation.dart';

class EnteredPasswordState with ChangeNotifier, DiagnosticableTreeMixin {
  var enteredPassword = '';
  var confirmedPassword = '';
  var isAuthenticating = false;

  updateEnteredPassword(String value) {
    enteredPassword = value;
    notifyListeners();
  }

  updateConfirmedPassword(String value) {
    confirmedPassword = value;
    notifyListeners();
  }

  updateBoolAuthenticating(bool value) {
    isAuthenticating = value;
    notifyListeners();
  }

  /// Makes `EnteredPhoneState` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('enteredPassword', enteredPassword));
    //properties.add(bool('isAuthenticating', isAuthenticating));
  }
}
