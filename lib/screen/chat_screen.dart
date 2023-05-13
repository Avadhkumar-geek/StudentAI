import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/message.dart';
import 'package:student_ai/widgets/search_bar.dart';

class ChatScreen extends StatefulWidget {
  final TextEditingController querycontroller;

  const ChatScreen({Key? key, required this.querycontroller}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageData> msgList = [];

  // List<MessageData> resData = [];
  final TextEditingController newQueryController = TextEditingController();
  bool _isTyping = false;
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void sendMessage(String query) {
    setState(() {
      msgList.insert(0, MessageData(text: query, sender: 'user'));
      _isTyping = true;
    });
  }

  Future<void> fetchData(String qry) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey!, qry);
      // print(query);
      setState(() {
        _isTyping = false;
        msgList.insert(0, MessageData(text: fetchRes, sender: 'AI'));
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  @override
  void initState() {
    sendMessage(widget.querycontroller.text);
    fetchData(widget.querycontroller.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              setState(
                () {
                  msgList.clear();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              // shrinkWrap: true,
              itemCount: msgList.length,
              itemBuilder: (context, index) => MessageData(
                sender: msgList[index].sender,
                text: msgList[index].text,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SearchBar(
            color: Colors.white60,
            chatController: newQueryController,
            onTap: () {
              if (newQueryController.text.isNotEmpty && !_isTyping) {
                sendMessage(newQueryController.text);
                fetchData(newQueryController.text);
              }
              newQueryController.clear();
            },
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
