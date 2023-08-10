import 'package:flutter/foundation.dart';

class VarificationCodeProviderState
    with ChangeNotifier, DiagnosticableTreeMixin {
  var isFilled = false;
  var isSending = false;
  var firstOnComplete = false;
  bool secondOnComplete = false;

  String first3digits = '000';
  String second3digits = '000';
  bool firstOnEditing = true;
  bool secondOnEditing = true;


  updateBoolfirstOnEditing(bool value) {
    firstOnEditing = value;
    notifyListeners();
  }

  updateBoolsecondOnEditing(bool value) {
    secondOnEditing = value;
    notifyListeners();
  }

  updateFirst3digits(String value) {
    first3digits = value;
    notifyListeners();
  }

  updateSecond3digits(String value) {
    second3digits = value;
    notifyListeners();
  }

  updateBoolisFilled(bool value) {
    isFilled = value;
    notifyListeners();
  }

  updateBoolfirstOnComplete(bool value) {
    firstOnComplete = value;
    notifyListeners();
  }

  updateBoolsecondOnComplete(bool value) {
    secondOnComplete = value;
    notifyListeners();
  }

  updateBoolisSending(bool value) {
    isSending = value;
    notifyListeners();
  }
}
