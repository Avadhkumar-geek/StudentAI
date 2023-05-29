import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/my_form.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/api_input.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/search_bar.dart';
import 'package:student_ai/widgets/server_indicator.dart';

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

  @override
  void initState() {
    super.initState();

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
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, kBackGroundColor, kOrange])),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: kBlack,
          centerTitle: true,
          title: Row(
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                width: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "StudentAI",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          actions: [
            ServerIndicator(isServerUp: isServerUp),
            IconButton(
              onPressed: () async {
                if (!isServerUp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.grey,
                      content: Text(
                        "Server is Down 🔻. Try again later!",
                        style: TextStyle(
                            color: kBlack, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ApiInput();
                    },
                  );
                }
              },
              icon: const Icon(Icons.key),
            ),
          ],
        ),
        body: Column(
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
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SearchBar(
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Apps for You",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
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
                    Container(
                      margin: const EdgeInsets.only(top: 100, bottom: 50),
                      child: Text.rich(
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                        TextSpan(
                          text: 'Made with ',
                          children: [
                            WidgetSpan(
                              child: Image.asset(
                                'assets/heart.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const TextSpan(text: ' by ∆ꪜꪖᦔꫝ in 🇮🇳'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
