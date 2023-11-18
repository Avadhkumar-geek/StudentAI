import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/logic/blocs/api/api_bloc.dart';
import 'package:student_ai/widgets/loading_widget.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MindMap extends StatefulWidget {
  final String data;

  const MindMap({Key? key, required this.data}) : super(key: key);

  @override
  State<MindMap> createState() => _MindMapState();
}

class _MindMapState extends State<MindMap> {
  String html = '';

  void fetchData(String qry) {
    BlocProvider.of<APIBloc>(context).add(APIRequestEvent(query: qry));
  }

  @override
  void initState() {
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
        body: BlocBuilder<APIBloc, APIState>(
          builder: (context, state) {
            if (state is APIRequestState) {
              return LoadingWidget(colors: colors, message: 'Generating Mind Map...');
            }

            if (state is APIFailedState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Something went wrong!!',
                      style: TextStyle(
                        fontSize: 25,
                        color: colors.kTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        color: kPrimaryColor,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          fetchData(widget.data);
                        },
                        child: Text(
                          'Retry',
                          style: TextStyle(
                            color: colors.kTextColor,
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
              );
            }
            if (state is APISuccessState) {
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
                         ${state.response}
                          </div>
                        </div>
                      </div>
                      <script type="module">
                    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
                  </script>
                    </body>
                  </html>
                  ''';

              return Stack(
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
                        },
                      ),
                    ),
                ],
              );
            }
            return LoadingWidget(colors: colors, message: 'Generating Mind Map...');
          },
        ));
  }
}
