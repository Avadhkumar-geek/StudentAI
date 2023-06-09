import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/my_form.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/apiKey_button.dart';
import 'package:student_ai/widgets/app_title.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/made_with.dart';
import 'package:student_ai/widgets/my_search_bar.dart';
import 'package:student_ai/widgets/server_indicator.dart';
import 'package:student_ai/widgets/support_us.dart';
import 'package:video_player/video_player.dart';

import '../data/constants.dart';
import '../data/form_json.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;
  bool isServerUp = false;
  final TextEditingController chatController = TextEditingController();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize().then((value) => setState(
          () {},
        ));
    _controller.setLooping(true);
    // _controller.play();

    ApiService.serverStatus().then((status) {
      setState(() {
        isServerUp = status;
      });
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      ApiService.serverStatus().then((status) {
        setState(() {
          isServerUp = status;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: kWhite,
        centerTitle: true,
        title: const AppTitle(),
        actions: [
          ServerIndicator(isServerUp: isServerUp),
          KeyButton(isServerUp: isServerUp),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller)),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "What's New to Learn",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              MySearchBar(
                buttonColor: kBlack,
                chatController: chatController,
                onTap: () {
                  if (chatController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          queryController: chatController.text,
                          isFormRoute: false,
                        ),
                      ),
                    ).then((value) => chatController.clear());
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Apps for You",
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: cardAspectRatio,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: formJSON.length,
                        itemBuilder: (context, index) {
                          final data = formJSON[index];
                          return CardWidget(
                            id: data['id'],
                            data: data,
                            pageRoute:
                                MyForm(id: data['id'], title: data['title']),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SupportUs(),
                      const MadeWith(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
