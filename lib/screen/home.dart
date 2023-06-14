import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/models/appdata_model.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/my_form.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/app_title.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/dummy_cards.dart';
import 'package:student_ai/widgets/key_button.dart';
import 'package:student_ai/widgets/made_with.dart';
import 'package:student_ai/widgets/my_search_bar.dart';
import 'package:student_ai/widgets/server_indicator.dart';
import 'package:student_ai/widgets/support_us.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Timer? timer;
  bool isServerUp = false;
  final TextEditingController chatController = TextEditingController();
  late AnimationController _aniController;
  List<AppData> appData = [];

  void loadApps() async {
    try {
      var data = await ApiService.getApps();
      setState(() {
        appData = data;
      });
      if (kDebugMode) {
        print(appData);
      }
    } catch (err) {
      if (kDebugMode) {
        print("Home error: $err");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    loadApps();
    ApiService.serverStatus().then((status) {
      setState(() {
        isServerUp = status;
      });
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      ApiService.serverStatus().then((status) {
        if (status != isServerUp) {
          setState(() {
            isServerUp = status;
          });
        }
      });
    });

    _aniController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _aniController.dispose();
    // _controller.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, kWhite, kOrange],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: kBlack,
          centerTitle: true,
          title: const AppTitle(),
          actions: [
            ServerIndicator(isServerUp: isServerUp),
            KeyButton(isServerUp: isServerUp),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Apps for You",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    appData.isEmpty
                        ? const DummyCards()
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: cardAspectRatio,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: appData.length,
                            itemBuilder: (context, index) {
                              final data = appData[index];
                              return CardWidget(
                                id: data.id,
                                data: data,
                                pageRoute: MyForm(id: data.id, title: data.title),
                                // MyForm(id: data.id, title: data.title),
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
      ),
    );
  }
}
