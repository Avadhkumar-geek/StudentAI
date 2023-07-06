library student_ai.globals;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ai/models/message_model.dart';
import 'package:student_ai/services/theme.dart';

String? apiKey = '';
bool isAPIValidated = false;
bool openai = false;

MyTheme currentTheme = MyTheme();
List<MessageModel> msgListGlobal = [];

getAPIKeyFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  apiKey = prefs.getString("apiKey");
  isAPIValidated = prefs.getBool("isAPIValidated")!;
}
