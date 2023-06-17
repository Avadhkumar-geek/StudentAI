import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/models/appdata_model.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/my_form.dart';
import 'package:student_ai/screen/search_screen.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/apikey_button.dart';
import 'package:student_ai/widgets/app_title.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/dummy_cards.dart';
import 'package:student_ai/widgets/made_with.dart';
import 'package:student_ai/widgets/more_button.dart';
import 'package:student_ai/widgets/my_search_bar.dart';
import 'package:student_ai/widgets/online_status.dart';
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
  final TextEditingController chatController = TextEditingController();
  late AnimationController _aniController;
  List<AppData> appData = [];
  bool isOnline = false;

  void loadApps() async {
    try {
      var data = await ApiService.getApps(limit: 5);
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
        isOnline = status;
      });
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      ApiService.serverStatus().then((status) {
        if (status != isOnline) {
          setState(() {
            isOnline = status;
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
        // centerTitle: true,
        title: const AppTitle(),
        actions: [
          OnlineStatus(
            isOnline: isOnline,
          ),
          const KeyButton(),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
              hintText: 'Ask Anything...',
              chatController: chatController,
              onChanged: () {},
              onComplete: () {},
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    _aniController.forward().then((value) => _aniController.reset());
                    if (openai && isAPIValidated == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('Enter a valid API Key'),
                          backgroundColor: kRed,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (!isOnline) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('Server is Down 🔻. Please, try again later!!'),
                          backgroundColor: kGrey,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (chatController.text.isNotEmpty) {
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

                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: kBlack,
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
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Apps for You",
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SearchScreen(),
                                  )),
                              child: const MoreButton())
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
