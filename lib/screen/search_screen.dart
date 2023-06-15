import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/models/appdata_model.dart';
import 'package:student_ai/screen/my_form.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/app_title.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/dummy_cards.dart';
import 'package:student_ai/widgets/my_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<AppData> appData = [];
  bool isTyping = false;
  bool isLoading = false;

  void loadApps() async {
    try {
      setState(() {
        isLoading = true;
      });
      var data = await ApiService.getApps(query: searchController.text.trim());
      setState(() {
        appData = data;
        isLoading = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: kWhite,
        title: const AppTitle(),
      ),
      body: Column(
        children: [
          MySearchBar(
            onComplete: () {
              loadApps();
            },
            onChanged: () {
              setState(() {
                isTyping = searchController.text.isNotEmpty;
              });
            },
            hintText: 'Search here',
            chatController: searchController,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: kBlack,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: isTyping
                      ? InkWell(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            setState(() {
                              searchController.clear();
                              isTyping = false;
                            });
                          },
                          child: const Icon(
                            Icons.cancel,
                            size: 30,
                            color: kWhite,
                          ),
                        )
                      : const Icon(
                          Icons.search,
                          size: 30,
                          color: kWhite,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          isLoading
              ? const DummyCards()
              : appData.isEmpty
                  ? const Center(
                      child: Text(
                        "No Data Available",
                        style: TextStyle(color: kWhite, fontSize: 20),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
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
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
