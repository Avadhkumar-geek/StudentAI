import 'dart:convert';

import 'package:student_ai/data/models/apps_metadata_model.dart';
import 'package:student_ai/data/models/apps_model.dart';
import 'package:http/http.dart' as http;

class StudentAiApiRepo {
  static Future<List<AppsModel>> getApps(
      {int? limit, String? query, int? page}) async {
    try {
      String url =
          'https://studentai-api.vercel.app/search?apps=${query ?? ""}&limit=${limit ?? 0}&page=${page ?? 0}';

      final res = await http.get(Uri.parse(url));

      Map<String, dynamic> data = jsonDecode(res.body);
      List<dynamic> dataList = data['result'];
      List<AppsModel> appData =
          dataList.map((e) => AppsModel.fromJson(e)).toList();

      return appData;
    } catch (e) {
      return [];
    }
  }

  static Future<AppMetadataModel> getAppsMetadata({required String id}) async {
    try {
      String url = 'https://studentai-api.vercel.app/id/$id';

      final res = await http.get(Uri.parse(url));

      Map<String, dynamic> data = jsonDecode(res.body);
      final metadata = AppMetadataModel.fromJson(data);

      return metadata;
    } catch (e) {
      return AppMetadataModel.fromJson({"x": "ca"});
    }
  }
}
