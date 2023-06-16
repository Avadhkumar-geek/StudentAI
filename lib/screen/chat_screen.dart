import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/data/secrets.dart';
import 'package:student_ai/models/message_model.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/indicator.dart';
import 'package:student_ai/widgets/message.dart';
import 'package:student_ai/widgets/my_search_bar.dart';
import 'package:student_ai/widgets/typing_animation.dart';

class ChatScreen extends StatefulWidget {
  final String queryController;
  bool isFormRoute;

  ChatScreen({Key? key, required this.queryController, required this.isFormRoute})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  List<MessageModel> msgList = [];

  late AnimationController _aniController;
  final TextEditingController newQueryController = TextEditingController();
  bool _isTyping = false;
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void sendMessage(String query) {
    if (widget.isFormRoute == false) {
      setState(() {
        msgList.insert(0, MessageModel(text: query, sender: 'user'));
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
      final String key = openai ? apiKey! : devApiKey!;
      String fetchRes = await ApiService.fetchApi(key, qry);

      setState(() {
        _isTyping = false;
        msgList.insert(0, MessageModel(text: fetchRes, sender: 'AI'));
      });
    } catch (e) {
      if (kDebugMode) {
        print("Chat Screen error: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    sendMessage(widget.queryController);
    _aniController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _aniController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: kChatBackGround,
      appBar: AppBar(
        foregroundColor: kWhite,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'ChatBot',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 16,
                ),
                Indicator(status: true)
              ],
            ),
            _isTyping ? const TypingAnimation() : Container(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_outlined),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: kBlack,
                title: const Text(
                  'Clear this chat?',
                  style: TextStyle(color: kWhite),
                ),
                content: const Text(
                  'This action can not be undone',
                  style: TextStyle(color: kWhite),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        msgList.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        color: kRadiumGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          MySearchBar(
            onComplete: () {},
            onChanged: () {},
            hintText: 'Ask Anything...',
            chatController: newQueryController,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _aniController.forward().then((value) => _aniController.reset());
                  if (newQueryController.text.isNotEmpty && !_isTyping) {
                    sendMessage(newQueryController.text);
                    newQueryController.clear();
                  }
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: _isTyping ? kGrey : kBlack,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.5).animate(_aniController),
                      child: SvgPicture.asset(
                        'assets/openai.svg',
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
