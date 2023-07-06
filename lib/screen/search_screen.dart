import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
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
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: colors.kTertiaryColor,
        foregroundColor: colors.kTextColor,
        title: AppTitle(isDarkMode: currentTheme.getTheme),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              searchController.text = utf8.decode(
                  base64.decode("VGhpcyBpcyB0aGUgcHJvcGVydHkgb2YgQXZhZGhrdW1hciBLYWNoaGFkaXlh"));
            },
            child: Container(
              width: 5,
              color: kTransparent,
            ),
          )
        ],
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
                  borderRadius: BorderRadius.circular(30),
                  color: colors.kTextColor,
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
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 40,
                            color: colors.kTertiaryColor,
                          ),
                        )
                      : Icon(
                          Icons.search,
                          size: 40,
                          color: colors.kTertiaryColor,
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
                  ? Center(
                      heightFactor: 10,
                      child: Text(
                        "No Data Available",
                        style: TextStyle(color: colors.kTextColor, fontSize: 20),
                      ))
                  : Expanded(
                      child: RefreshIndicator(
                        edgeOffset: -20,
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        onRefresh: () async {
                          loadApps();
                        },
                        color: Colors.red,
                        backgroundColor: Colors.white,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: MediaQuery.of(context).size.width * 0.0021,
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
                    ),
        ],
      ),
    );
  }
}
