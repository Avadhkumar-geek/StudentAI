import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/data/repositories/auth_repo.dart';
import 'package:student_ai/data/repositories/ai_model_repo.dart';
import 'package:student_ai/data/repositories/studentai_api_repo.dart';
import 'package:student_ai/data/repositories/user_repo.dart';
import 'package:student_ai/firebase_options.dart';
import 'package:student_ai/logic/blocs/apps/apps_bloc.dart';
import 'package:student_ai/logic/blocs/auth/auth_bloc.dart';
import 'package:student_ai/logic/blocs/custom_app/custom_app_bloc.dart';
import 'package:student_ai/logic/blocs/internet/internet_bloc.dart';
import 'package:student_ai/logic/blocs/api/api_bloc.dart';
import 'package:student_ai/logic/blocs/updater/updater_cubit.dart';
import 'package:student_ai/logic/blocs/user/user_bloc.dart';
import 'package:student_ai/logic/blocs/validator/validator_bloc.dart';
import 'package:student_ai/presentation/screens/home/home.dart';
import 'package:student_ai/presentation/screens/login/login.dart';
import 'package:student_ai/presentation/screens/updater/update_listener.dart';
import 'package:wiredash/wiredash.dart';

import 'logic/blocs/chat/chat_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      feedbackOptions: const WiredashFeedbackOptions(
        labels: [
          Label(
            id: 'label-jmr4ih3qig',
            title: 'Bug',
          ),
          Label(
            id: 'label-6icfkrtiil',
            title: 'Improvement',
          ),
          Label(
            id: 'label-jyi00inv6e',
            title: 'Feature Request',
          ),
        ],
      ),
      theme: WiredashThemeData.fromColor(
        primaryColor: kPrimaryColor,
        secondaryColor: kSecondaryColor,
        brightness: currentTheme.getTheme ? Brightness.dark : Brightness.light,
      ),
      projectId: 'studentai-4joyq7b',
      secret: 'R9Q1KSg6aUbRpkB-l4S_mnmUDRD6V2md',
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthRepo(),
          ),
          RepositoryProvider(
            create: (context) => AIModelRepo(),
          ),
          RepositoryProvider(
            create: (context) => StudentAiApiRepo(),
          ),
          RepositoryProvider(
            create: (context) => UserRepo(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => InternetBloc(
                connectivity: Connectivity(),
              ),
            ),
            BlocProvider(
              create: (context) => AuthBloc(
                authRepo: RepositoryProvider.of<AuthRepo>(context),
              ),
            ),
            BlocProvider(
              create: (context) => APIBloc(
                aiModelRepo: RepositoryProvider.of<AIModelRepo>(context),
              ),
            ),
            BlocProvider(
              create: (context) => ValidatorBloc(
                aiModelRepo: RepositoryProvider.of<AIModelRepo>(context),
              ),
            ),
            BlocProvider<HomeBloc>(
              create: (context) => AppsBloc(
                studentAiApiRepo: RepositoryProvider.of<StudentAiApiRepo>(context),
              ),
            ),
            BlocProvider(
              create: (context) => CustomAppsBloc(
                userRepo: RepositoryProvider.of<UserRepo>(context),
              ),
            ),
            BlocProvider(
              create: (context) => UserBloc(
                userRepo: RepositoryProvider.of<UserRepo>(context),
              ),
            ),
            BlocProvider(
              create: (context) => ChatBloc(),
            ),
            BlocProvider(create: (_) => UpdaterCubit()..init()),
          ],
          child: MaterialApp(
            darkTheme: ThemeData(
              extensions: const <ThemeExtension<AppColors>>[
                AppColors(
                  kSecondaryColor: kSecondaryColorLight,
                  kTertiaryColor: kTertiaryColorLight,
                  kTextColor: kWhite,
                ),
              ],
              fontFamily: "Ubuntu",
              useMaterial3: true,
              textTheme: GoogleFonts.dmSansTextTheme(),
            ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              extensions: const <ThemeExtension<AppColors>>[
                AppColors(
                  kSecondaryColor: kSecondaryColor,
                  kTertiaryColor: kTertiaryColor,
                  kTextColor: kTextColor,
                ),
              ],
              fontFamily: "Ubuntu",
              useMaterial3: true,
              textTheme: GoogleFonts.dmSansTextTheme(),
            ),
            themeMode: currentTheme.currentTheme(),
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const UpdateListener(child: Home());
                  }
                  return const LoginScreen();
                }),
          ),
        ),
      ),
    );
  }
}
