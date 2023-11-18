import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/models/apps_model.dart';
import 'package:student_ai/logic/blocs/custom_app/custom_app_bloc.dart';
import 'package:student_ai/presentation/screens/custom_apps/create_app_form.dart';
import 'package:student_ai/presentation/screens/custom_apps/custom_app_form.dart';
import 'package:student_ai/presentation/screens/home/widgets/card_widget.dart';
import 'package:student_ai/presentation/screens/home/widgets/add_app_widget.dart';
import 'package:student_ai/presentation/screens/home/widgets/dummy_cards.dart';

class CustomApps extends StatefulWidget {
  const CustomApps({super.key});

  @override
  State<CustomApps> createState() => _CustomAppsState();
}

class _CustomAppsState extends State<CustomApps> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CustomAppsBloc>().add(CustomAppsGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Your Apps",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: colors.kTextColor),
          ),
        ),
        BlocConsumer<CustomAppsBloc, CustomAppState>(
          listener: (context, state) {
            if (state is CustomAppStateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kRed,
                  content: Text(state.error),
                ),
              );
            }
            if (state is CustomAppStateUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: kBlue,
                  content: Text("Updated successfully!!"),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CustomAppStateLoading) {
              return const DummyCards();
            }
            if (state is CustomAppStateFailed) {
              return const DummyCards();
            }
            if (state is CustomAppStateLoaded) {
              final apps = state.apps;
              for (var e in apps) {
                log(e.toJson().toString());
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: cardAspectRatio,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: apps.length + 1,
                itemBuilder: (context, index) {
                  if (index < apps.length) {
                    final data = apps[index];
                    return CardWidget(
                      id: data.appId,
                      data: AppsModel(
                          title: data.title,
                          icon: '0xe08f',
                          id: data.appId,
                          disc: data.desc,
                          color: '0xFF448AFF'),
                      pageRoute: CustomAppFormPage(customAppData: data),
                      action: PopupMenuButton<String>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        position: PopupMenuPosition.under,
                        surfaceTintColor: kPrimaryColor,
                        icon: Icon(
                          Icons.more_vert,
                          color: colors.kTextColor,
                        ),
                        onSelected: (val) {
                          switch (val) {
                            case 'Edit':
                              showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                showDragHandle: true,
                                backgroundColor: colors.kTertiaryColor,
                                context: context,
                                builder: (context) => CreateAppForm(
                                  customAppData: data,
                                ),
                              );
                              break;
                            case 'Delete':
                              BlocProvider.of<CustomAppsBloc>(context).add(
                                CustomAppDeleteEvent(
                                  appId: data.appId,
                                ),
                              );
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Edit', 'Delete'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    );
                  } else {
                    return const AddApp();
                  }
                },
              );
            }
            return const DummyCards();
          },
        ),
      ],
    );
  }
}
