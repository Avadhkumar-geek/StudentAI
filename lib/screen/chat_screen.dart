import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/ani.dart';
import 'package:student_ai/widgets/message.dart';
import 'package:student_ai/widgets/search_bar.dart';

class ChatScreen extends StatefulWidget {
  final String queryController;
  final bool isFormRoute;

  const ChatScreen(
      {Key? key, required this.queryController, required this.isFormRoute})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> msgList = [];

  final TextEditingController newQueryController = TextEditingController();
  bool _isTyping = false;
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void sendMessage(String query) {
    if (widget.isFormRoute == false) {
      setState(() {
        msgList.insert(0, Message(text: query, sender: 'user'));
      });
    }
    setState(() {
      _isTyping = true;
    });
    fetchData(query);
  }

  Future<void> fetchData(String qry) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey!, qry);
      // print(query);
      setState(() {
        _isTyping = false;
        msgList.insert(0, Message(text: fetchRes, sender: 'AI'));
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  @override
  void initState() {
    sendMessage(widget.queryController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        foregroundColor: kBlack,
        backgroundColor: kForeGroundColor,
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_outlined),
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
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              // shrinkWrap: true,
              itemCount: msgList.length,
              itemBuilder: (context, index) => Message(
                sender: msgList[index].sender,
                text: msgList[index].text,
              ),
            ),
          ),
          _isTyping ? TypingAnimation2() : Container(),
          const SizedBox(
            height: 16,
          ),
          SearchBar(
            chatController: newQueryController,
            onTap: () {
              if (newQueryController.text.isNotEmpty && !_isTyping) {
                sendMessage(newQueryController.text);
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
