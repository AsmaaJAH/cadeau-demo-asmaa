import 'package:flutter/foundation.dart';

class LoginTokenState with ChangeNotifier, DiagnosticableTreeMixin {
  var loginToken = '';


  updateLoginToken(String token) {
    loginToken = token;
    notifyListeners();
  }
}
