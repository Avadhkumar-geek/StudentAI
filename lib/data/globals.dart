library student_ai.globals;

import 'package:shared_preferences/shared_preferences.dart';

String? apiKey = '';
bool isAPIValidated = false;

getAPIKeyFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  apiKey = prefs.getString("apiKey");
  isAPIValidated = prefs.getBool("isAPIValidated")!;
}
