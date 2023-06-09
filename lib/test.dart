import 'package:http/http.dart' as http;

void test(String filepath, String url) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath('file', filepath));
  var res = await request.send();
  print(res);
}

void main() async {
  String filename = 'a.txt';
  String dirPath = 'assets';
  String filepath = '$dirPath/$filename';
  test(filepath,
      'http://127.0.0.1:5000/?file=$filename&query=what is your name');
}
