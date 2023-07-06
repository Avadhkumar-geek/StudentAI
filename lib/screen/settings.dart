import 'package:flutter/material.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/screen/about.dart';
import 'package:student_ai/screen/api_config.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final MaterialStateProperty<Icon> thumbIcon = MaterialStateProperty.resolveWith((states) {
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
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                "API Configuration",
                style: TextStyle(color: colors.kTextColor, fontSize: 18),
              ),
              tileColor: colors.kSecondaryColor,
              leading: Icon(
                Icons.key,
                color: colors.kTextColor,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApiConfig(),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
            )
          ],
        ).toList(),
      ),
    );
  }
}
