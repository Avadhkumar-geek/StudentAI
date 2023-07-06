import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/data/secrets.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MindMap extends StatefulWidget {
  final String data;

  const MindMap({Key? key, required this.data}) : super(key: key);

  @override
  State<MindMap> createState() => _MindMapState();
}

class _MindMapState extends State<MindMap> {
  String html = '';
  bool _isLoading = true;

  Future<void> fetchData(String qry) async {
    final String key = openai ? apiKey! : devApiKey!;
    String fetchRes = await ApiService.fetchApi(key, qry);

    setState(() {
      html = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
  </head>
  <body>
    <div class="card" style="display:block">
      <div class="card-content">
        <div class="mermaid">
       $fetchRes
        </div>
      </div>
    </div>
    <script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
</script>
  </body>
</html>
''';
      print(html);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        backgroundColor: colors.kTertiaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: colors.kTextColor,
          title: const Text("Mind Map"),
        ),
        body: Stack(
          children: [
            if (html != '')
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: WebViewPlus(
                  backgroundColor: colors.kTertiaryColor,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                  },
                  zoomEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    controller.loadString(html);
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              ),
            if (_isLoading)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Generating Mind Map...',
                    style: TextStyle(
                      fontSize: 25,
                      color: colors.kTextColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80.0),
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
          ],
        ));
  }
}
