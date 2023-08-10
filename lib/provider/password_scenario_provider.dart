import 'package:flutter/foundation.dart';

class ResetScenarioState with ChangeNotifier, DiagnosticableTreeMixin {
  var resetedPhone = '';
  var resetedCountryCode = "+20";
  var verificationCode = "000000";
  var resetedPassToken = '';
  var isResendCode = false;

  updateBoolIsResendCode(bool value) {
    isResendCode = value;
    notifyListeners();
  }

  updateResetedToken(String token) {
    resetedPassToken = token;
    notifyListeners();
  }

  updateResetedPhone(String newValue) {
    resetedPhone = newValue;
    notifyListeners();
  }

  updateVerificationCode(String value) {
    verificationCode = value;
    notifyListeners();
  }

  updateResetedCountryCode(String newCode) {
    resetedCountryCode = newCode;
    //debugPrint(enteredCountryCode);
    notifyListeners();
  }

  /// Makes `EnteredPhoneState` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('resetedPhone', resetedPhone));
    properties.add(StringProperty('resetedCountryCode', resetedCountryCode));
    properties.add(StringProperty('resetedPassToken', verificationCode));
  }
}
