import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/logic/blocs/apps/apps_bloc.dart';
import 'package:student_ai/presentation/screens/form/my_form.dart';
import 'package:student_ai/presentation/screens/home/widgets/app_title.dart';
import 'package:student_ai/presentation/screens/home/widgets/card_widget.dart';
import 'package:student_ai/presentation/screens/home/widgets/dummy_cards.dart';
import 'package:student_ai/presentation/screens/search/widgets/my_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isTyping = false;

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
              width: 10,
              color: kTransparent,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          MySearchBar(
            onEditingComplete: () {
              context.read<SearchBloc>().add(AppsGetEvent(query: searchController.text.trim()));
            },
            onChanged: (String val) {
              setState(() {
                isTyping = searchController.text.isNotEmpty;
              });
            },
            textInputAction: TextInputAction.search,
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
            height: 16, // You can adjust the height here if needed.
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.95, 1],
                  colors: [
                    kWhite,
                    kWhite.withOpacity(0),
                  ],
                ).createShader(rect);
              },
              child: RefreshIndicator(
                edgeOffset: -20,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  context.read<SearchBloc>().add(AppsGetEvent());
                },
                color: Colors.red,
                backgroundColor: Colors.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<SearchBloc, AppsState>(
                        builder: (context, state) {
                          if (state.status == AppStateStatus.initial) {
                            context.read<SearchBloc>().add(AppsGetEvent());
                          }
                          if (state.status == AppStateStatus.loading) {
                            return const DummyCards();
                          }
                          if (state.status == AppStateStatus.loaded) {
                            final apps = state.apps;
                            if (apps.isEmpty) {
                              return Text(
                                "No Data Available",
                                style: TextStyle(color: colors.kTextColor, fontSize: 20),
                              );
                            }
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context).size.width * 0.0021,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: apps.length,
                              itemBuilder: (context, index) {
                                final data = apps[index];
                                return CardWidget(
                                  id: data.id,
                                  data: data,
                                  pageRoute: MyFormPage(id: data.id, title: data.title),
                                );
                              },
                            );
                          }
                          if (state.status == AppStateStatus.failed) {
                            return Text(
                              "No Data Available",
                              style: TextStyle(color: colors.kTextColor, fontSize: 20),
                            );
                          }
                          return const DummyCards();
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
          ),
        ],
      ),
    );
  }
}
