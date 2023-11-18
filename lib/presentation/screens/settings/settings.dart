import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/logic/blocs/auth/auth_bloc.dart';
import 'package:student_ai/presentation/screens/about/about.dart';
import 'package:student_ai/presentation/screens/profile/profile_screen.dart';
import 'package:student_ai/presentation/screens/settings/api_config.dart';
import 'package:student_ai/presentation/screens/login/login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final MaterialStateProperty<Icon> thumbIcon =
      MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(
        Icons.dark_mode,
        color: Colors.white,
      );
    } else {
      return const Icon(
        Icons.light_mode,
        color: Colors.black,
      );
    }
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        backgroundColor: colors.kTertiaryColor,
        foregroundColor: colors.kTextColor,
        title: Text(
          "Settings",
          style: TextStyle(color: colors.kTextColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: ListTile.divideTiles(
          color: colors.kTertiaryColor,
          context: context,
          tiles: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                "Profile",
                style: TextStyle(color: colors.kTextColor, fontSize: 18),
              ),
              tileColor: colors.kSecondaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              leading: Icon(
                Icons.account_circle_rounded,
                color: colors.kTextColor,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                "API Configuration",
                style: TextStyle(color: colors.kTextColor, fontSize: 18),
              ),
              tileColor: colors.kSecondaryColor,
              leading: Icon(
                Icons.key,
                color: colors.kTextColor,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApiConfig(),
                ),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                "Theme",
                style: TextStyle(color: colors.kTextColor, fontSize: 18),
              ),
              tileColor: colors.kSecondaryColor,
              leading: Icon(
                Icons.contrast,
                color: colors.kTextColor,
              ),
              trailing: Switch(
                thumbIcon: thumbIcon,
                // thumbColor: MaterialStateProperty.all(Colors.black),
                activeTrackColor: Colors.white,
                activeColor: Colors.indigo,
                inactiveThumbColor: Colors.amber,
                inactiveTrackColor: Colors.white,
                value: currentTheme.getTheme,
                onChanged: (value) {
                  setState(() {
                    currentTheme.switchTheme();
                  });
                },
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                "Licenses",
                style: TextStyle(color: colors.kTextColor, fontSize: 18),
              ),
              tileColor: colors.kSecondaryColor,
              leading: Icon(
                Icons.receipt_long,
                color: colors.kTextColor,
              ),
              onTap: () => showLicensePage(
                context: context,
                applicationName: "StudentAI",
                applicationIcon: SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  height: 60,
                ),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                "About",
                style: TextStyle(color: colors.kTextColor, fontSize: 18),
              ),
              tileColor: colors.kSecondaryColor,
              leading: Icon(
                Icons.info,
                color: colors.kTextColor,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const About(),
                ),
              ),
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is DeAuth) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(LogOutEvent());
                  }),
            ),
          ],
        ).toList(),
      ),
    );
  }
}
