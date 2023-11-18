import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AIModelRepo {
  Future<String> apiRequest(String apiKey, String query) async {
    // try {
    //   const String url = 'https://api.openai.com/v1/chat/completions';
    //
    //   final Map<String, String> headers = {
    //     'authorization': 'Bearer $apiKey',
    //     'Content-Type': 'application/json'
    //   };
    //
    //   final Map<String, dynamic> body = {
    //     'model': 'gpt-3.5-turbo',
    //     'messages': [
    //       {
    //         'role': 'user',
    //         'content': query,
    //       }
    //     ],
    //   };
    //
    //   final response = await http.post(Uri.parse(url),
    //       headers: headers, body: json.encode(body));
    //
    //   final jsonToMap =
    //       jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    //
    //   String output = '';
    //
    //   jsonToMap['choices'].forEach((choice) {
    //     String content = choice['message']['content'];
    //     output += content;
    //   });
    //
    //   return output;
    // } catch (_) {
    //   return "Something went wrong!!";
    // }

    try {
      String url =
          'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$apiKey';

      log(apiKey);
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      final Map<String, dynamic> data = {
        "prompt": {"text": query}
      };

      final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));

      Map<String, dynamic> resData = jsonDecode(const Utf8Decoder().convert(res.bodyBytes));

      String output = "";
      resData['candidates'].forEach((choice) {
        String content = choice['output'];
        output += content;
      });

      return output;
    } catch (e) {
      log(e.toString());
      throw Exception("Something went wrong!!");
    }
  }
}
