import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/message.dart';

class Answer extends StatefulWidget {
  const Answer({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  List<MessageData> msgList = [];
  bool _isLoading = false;

  Future<void> fetchData(String qry) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey!, qry);
      // print(query);
      setState(() {
        _isLoading = false;
        msgList.insert(0, MessageData(text: fetchRes, sender: 'AI'));
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    _isLoading = true;
    fetchData(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        backgroundColor: kDarkWhite,
        foregroundColor: kWhite,
        title: const Text(
          'Answer',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: kWhite,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: kDeepOrange,
                        ))
                      : Text(
                          msgList[0].text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            MaterialButton(
              onPressed: () {
                FlutterClipboard.copy(msgList[0].text);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Copied!!'),
                  backgroundColor: Colors.indigoAccent,
                ));
              },
              color: kDeepOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'COPY',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: kWhite),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
