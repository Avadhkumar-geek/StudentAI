import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/models/apps_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.data,
    required this.pageRoute,
    required this.id,
    this.action,
  }) : super(key: key);

  final AppsModel data;
  final Widget pageRoute;
  final String id;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    int iconData = int.parse(data.icon);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: colors.kSecondaryColor,
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (context) => pageRoute,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(int.parse(data.color.toString())),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.kSecondaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      IconData(iconData, fontFamily: 'MaterialIcons'),
                      size: 30,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                action ?? const SizedBox(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    data.disc,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                        // color: kBlack.withOpacity(0.54),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
