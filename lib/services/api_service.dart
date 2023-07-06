import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/models/appdata_model.dart';

class ApiService {
  static Future<String> fetchApi(String apiKey, String content) async {
    try {
      const String defaultUrl = 'https://chimeragpt.adventblocks.cc/v1/chat/completions';
      const String openaiUrl = 'https://api.openai.com/v1/chat/completions';
      String url = openai ? openaiUrl : defaultUrl;

      final Map<String, String> headers = {
        'authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': openai ? 'gpt-3.5-turbo' : 'gpt-4',
        'messages': [
          {
            'role': 'user',
            'content': content,
          }
        ],
      };

      final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));

      Map<String, dynamic> resData = jsonDecode(const Utf8Decoder().convert(res.bodyBytes));

      String output = "";
      resData['choices'].forEach((choice) {
        String content = choice['message']['content'];
        output += content;
      });

      if (kDebugMode) {
        print("url: $url");
        // print(resData);
      }

      return output;
    } catch (e) {
      print('API Error: $e');
      return "Something went wrong!! Please, try again later.";
    }
  }

  static Future<bool> validateApiKey(String apiKey) async {
    try {
      const String url = 'https://api.openai.com/v1/chat/completions';

      final Map<String, String> headers = {
        'authorization': "Bearer $apiKey",
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': "say 'a'",
          }
        ],
      };

      final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));

      // if (kDebugMode) {
      //   print('Status Code: ${res.statusCode}');
      //   print(res.body);
      // }

      return res.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return false;
    }
  }

  static Future<bool> serverStatus() async {
    try {
      const String url = 'https://chimeragpt.adventblocks.cc';

      final res = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print('Status Code: ${res.statusCode}');
      }
      if (kDebugMode) {
        print(res.body);
      }

      if (kDebugMode) {
        print('Status Code: ${res.statusCode}');
      }

      // if (kDebugMode) {
      //   print(res.body);
      // }

      return res.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
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
