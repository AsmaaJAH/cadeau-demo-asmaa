import 'package:flutter/foundation.dart';

class EnteredPhoneState with ChangeNotifier, DiagnosticableTreeMixin {
  var enteredPhone = '';
  var enteredCountryCode = "+20";
  var isSending = false;

  updateBoolSending(bool value) {
    isSending = value;
    notifyListeners();
  }

  updateEnteredPhone(String newValue) {
    enteredPhone = newValue;
    notifyListeners();
  }

  updateCountryCode(String newCode) {
    enteredCountryCode = newCode;
    //debugPrint(enteredCountryCode);
    notifyListeners();
  }

  /// Makes `EnteredPhoneState` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('enteredPhone', enteredPhone));
    properties.add(StringProperty('enteredCountryCode', enteredCountryCode));
  }
}
