import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:student_ai/data/constants.dart';

/*
curl --location 'https://api.pawan.krd/v1/chat/completions' \
--header 'authorization: Bearer apiKey' \
--header 'Content-Type: application/json' \
--data '{"model":"gpt-3.5-turbo","messages":[{"role":"user","content":"Rewrite in "}],"max_tokens":2048}'

*/

class ApiService {
  static Future<String> fetchApi(String apiKey, String content) async {
    try {
      const String url =
          'https://chimeragpt.adventblocks.cc/v1/chat/completions';

      final Map<String, String> headers = {
        // 'authorization': 'Bearer ${dotenv.env['API_KEY']!}',
        'authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-4',
        'messages': [
          {
            "role": "system",
            "content": formatter,
          },
          {
            'role': 'user',
            'content': content,
          }
        ],
      };

      final res = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      Map<String, dynamic> resData = jsonDecode(res.body);

      String output = "";
      resData['choices'].forEach((choice) {
        String content = choice['message']['content'];
        output += content;
      });
      print(resData);

      return output;
    } catch (e) {
      return "Something went wrong!! Please, try again later.";
    }
  }

  static Future<bool> validateApiKey(String apiKey) async {
    try {
      const String url =
          'https://chimeragpt.adventblocks.cc/v1/chat/completions';

      final Map<String, String> headers = {
        // 'authorization': 'Bearer ${dotenv.env['API_KEY']!}',
        'authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'user',
            'content': 'hi',
          }
        ],
      };

      final res = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      // print('Status Code: ${res.statusCode}');
      // print(res.body);

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> serverStatus() async {
    try {
      const String url = 'https://chimeragpt.adventblocks.cc/';

      final res = await http.get(Uri.parse(url));

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
