import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:student_ai/data/secrets.dart';
import 'package:student_ai/models/appdata_model.dart';

/*
curl --location 'https://api.pawan.krd/v1/chat/completions' \
--header 'authorization: Bearer apiKey' \
--header 'Content-Type: application/json' \
--data '{"model":"gpt-3.5-turbo","messages":[{"role":"user","content":"Rewrite in "}],"max_tokens":2048}'

*/

class ApiService {
  static Future<String> fetchApi(String apiKey, String content) async {
    try {
      const String url = 'https://chimeragpt.adventblocks.cc/v1/chat/completions';


      final Map<String, String> headers = {
        // devApiKey is used for development purpose
        'authorization': 'Bearer ${devApiKey ?? apiKey}',
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'user',
            'content': content,
          }
        ],
      };

      final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));

      Map<String, dynamic> resData = jsonDecode(const Utf8Decoder().convert(res.bodyBytes));

      String output = '';
      resData['choices'].forEach((choice) {
        String content = choice['message']['content'];
        output += content;
      });

      if (kDebugMode) {
        print("url: $url");
        print(resData);
      }

      return output;
    } catch (e) {
      return "Something went wrong!! Please, try again later.";
    }
  }

  static Future<bool> validateApiKey(String apiKey) async {
    try {
      const String url = 'https://chimeragpt.adventblocks.cc/v1/chat/completions';

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
            'content': '2+2=',
          }
        ],
      };

      final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));

      // print('Status Code: ${res.statusCode}');
      // print(res.body);

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<AppData>> getApps({int? limit, String? query, int? page}) async {
    try {
      String url =
          'https://studentai-api.vercel.app/search?apps=${query ?? ""}&limit=${limit ?? 0}&page=${page ?? 0}';

      final res = await http.get(Uri.parse(url));

      Map<String, dynamic> data = jsonDecode(res.body);
      List<dynamic> dataList = data['result'];
      List<AppData> appData = dataList.map((e) => AppData.fromJson(e)).toList();

      // if (kDebugMode) {
      //   print("Results: ${data['results']}");
      // }

      return appData;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return [];
    }
  }

  static Future<Map<String, dynamic>> getFormData(String id) async {
    try {
      String url = 'https://studentai-api.vercel.app/id/$id';

      final res = await http.get(Uri.parse(url));

      Map<String, dynamic> data = jsonDecode(res.body);
      Map<String, dynamic> formData = data['result'];

      // if (kDebugMode) {
      //   print("Result: ${data['result']}");
      // }
      //
      return formData;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return {};
    }
  }
}
