import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/models/appdata_model.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/my_form.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/app_title.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/dummy_cards.dart';
import 'package:student_ai/widgets/made_with.dart';
import 'package:student_ai/widgets/more_button.dart';
import 'package:student_ai/widgets/my_search_bar.dart';
import 'package:student_ai/widgets/online_status.dart';
import 'package:student_ai/widgets/settings_button.dart';
import 'package:student_ai/widgets/support_us.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // late NativeAd _ad;
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

    // _ad = NativeAd(
    //   nativeTemplateStyle: NativeTemplateStyle(
    //     callToActionTextStyle:
    //         NativeTemplateTextStyle(textColor: Colors.red, backgroundColor: kPrimaryColor),
    //     templateType: TemplateType.medium,
    //     primaryTextStyle: NativeTemplateTextStyle(
    //       textColor: Colors.black,
    //     ),
    //     secondaryTextStyle: NativeTemplateTextStyle(
    //       textColor: currentTheme.getTheme ? Colors.black : Colors.white,
    //     ),
    //     tertiaryTextStyle: NativeTemplateTextStyle(
    //       textColor: currentTheme.getTheme ? Colors.black : Colors.white,
    //     ),
    //   ),
    //   adUnitId: AdHelper.nativeAdUnitId,
    //   factoryId: 'listTile',
    //   request: const AdRequest(),
    //   listener: NativeAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _ad = ad as NativeAd;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       // Releases an ad resource when it fails to load
    //       ad.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');
    //     },
    //   ),
    // );
    //
    // _ad.load();
  }

  @override
  void dispose() {
    super.dispose();
    _aniController.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        surfaceTintColor: kTransparent,
        backgroundColor: colors.kTertiaryColor,
        foregroundColor: colors.kTextColor,
        // centerTitle: true,
        title: AppTitle(
          isDarkMode: currentTheme.getTheme,
        ),
        actions: [
          OnlineStatus(
            isOnline: isOnline,
          ),
          const SettingsButton(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "What's New to Learn",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: colors.kTextColor),
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
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Server is Down 🔻. Please, try again later!!'),
                        backgroundColor: colors.kTextColor,
                        duration: const Duration(seconds: 1),
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
                    borderRadius: BorderRadius.circular(30),
                    color: colors.kTextColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.5).animate(_aniController),
                      child: SvgPicture.asset(
                        'assets/openai.svg',
                        width: 40,
                        colorFilter: ColorFilter.mode(
                          colors.kTertiaryColor!,
                          BlendMode.srcIn,
                        ),
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
            child: RefreshIndicator(
              edgeOffset: -20,
              onRefresh: () async {
                loadApps();
              },
              color: kPrimaryColor,
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Apps for You",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600, color: colors.kTextColor),
                      ),
                    ),
                    appData.isEmpty
                        ? const DummyCards()
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context).size.width * 0.0021,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: appData.length + 1,
                            itemBuilder: (context, index) {
                              if (index < appData.length) {
                                final data = appData[index];
                                return CardWidget(
                                  id: data.id,
                                  data: data,
                                  pageRoute: MyForm(id: data.id, title: data.title),
                                );
                              } else {
                                return const MoreButton();
                              }
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   height: 350.0,
                    //   alignment: Alignment.center,
                    //   child: AdWidget(ad: _ad),
                    // ),
                    const SupportUs(),
                    const MadeWith(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
