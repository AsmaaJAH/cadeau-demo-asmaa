import 'package:shared_preferences/shared_preferences.dart';

const kBaseURL = "http://3.72.221.79/api";
const kVersion = 'v1';

const kQueryParameters = {
  'user_type': 'customer',
};
const kFcmToken = "dummy";

final Future<SharedPreferences> kPreferencesToken = SharedPreferences.getInstance();

