import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/logic/blocs/internet/internet_bloc.dart';
import 'package:student_ai/logic/blocs/user/user_bloc.dart';
import 'package:student_ai/logic/blocs/validator/validator_bloc.dart';
import 'package:student_ai/presentation/screens/home/widgets/app_title.dart';
import 'package:student_ai/presentation/screens/home/widgets/apps.dart';
import 'package:student_ai/presentation/screens/custom_apps/widgets/custom_apps.dart';
import 'package:student_ai/presentation/screens/home/widgets/made_with.dart';
import 'package:student_ai/presentation/screens/home/widgets/my_header_delegate.dart';
import 'package:student_ai/presentation/screens/settings/api_config.dart';
import 'package:student_ai/widgets/no_internet.dart';
import 'package:student_ai/presentation/screens/settings/widgets/settings_button.dart';
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
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    BlocProvider.of<ValidatorBloc>(context).add(ValidateAPIKeyFromStorage());
  }

  @override
  void dispose() {
    _animationController.dispose();
    chatController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      body: BlocListener<ValidatorBloc, ValidatorState>(
        listener: (context, state) {
          if (state is ValidatorStorageAPIFailed) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApiConfig(),
                ));
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: colors.kTertiaryColor,
              expandedHeight: 120,
              // Adjust as needed
              surfaceTintColor: kTransparent,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: AppTitle(
                  isDarkMode: currentTheme.getTheme,
                ),
              ),
              actions: const [
                SettingsButton(),
              ],
            ),
            SliverPersistentHeader(
              delegate: MyHeaderDelegate(_animationController, chatController),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocBuilder<InternetBloc, InternetState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: state is InternetDisconnectedState,
                        child: const NoInternet(),
                      );
                    },
                  ),
                  const Apps(),
                  const CustomApps(),
                  const SizedBox(height: 20),
                  const SupportUs(),
                  const MadeWith(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
