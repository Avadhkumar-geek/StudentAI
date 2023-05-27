import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: kForeGroundColor,
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ApiInput();
                },
              );
            },
            icon: const Icon(Icons.key),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Flexible(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  pageRoute: MyForm(id: data['id'], title: data['title']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
