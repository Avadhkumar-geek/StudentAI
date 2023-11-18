import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/logic/blocs/auth/auth_bloc.dart';
import 'package:student_ai/presentation/screens/home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } else if (state is AuthFail) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMsg)));
        }
      },
      child: Scaffold(
        backgroundColor: colors.kTertiaryColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/svgs/login.svg",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: colors.kTextColor),
                const TextSpan(
                  text: "Welcome, Learner!\n",
                  children: [
                    TextSpan(
                      text: 'Elevate Your Learning Effortlessly with',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextSpan(
                      text: '\nStudentAI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _login(context);
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                decoration: BoxDecoration(
                    color: colors.kSecondaryColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2)),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthInit) {
                      return const CircularProgressIndicator(
                        color: kPrimaryColor,
                      );
                    } else {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/svgs/google.svg", width: 35),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "Continue with Google",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(context) {
    BlocProvider.of<AuthBloc>(context).add(LogInEvent());
  }
}
