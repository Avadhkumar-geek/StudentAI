import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/message.dart';
import 'package:student_ai/widgets/search_bar.dart';
import 'package:student_ai/widgets/typing_animation.dart';

class ChatScreen extends StatefulWidget {
  final String queryController;
  bool isFormRoute;

  ChatScreen(
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
      widget.isFormRoute = false;
    });
    fetchData(query);
  }

  Future<void> fetchData(String qry) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey!, qry);

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
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kOrange, Colors.blue])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: kBlack,
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chat',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              _isTyping ? const TypingAnimation() : Container(),
            ],
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
            const SizedBox(
              height: 16,
            ),
            SearchBar(
              buttonColor: _isTyping ? kDarkWhite : kBlack,
              chatController: newQueryController,
              onTap: () {
                if (newQueryController.text.isNotEmpty && !_isTyping) {
                  sendMessage(newQueryController.text);
                  newQueryController.clear();
                }
              },
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
