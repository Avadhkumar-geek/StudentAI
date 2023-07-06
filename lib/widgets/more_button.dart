import 'package:flutter/material.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/screen/search_screen.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          )),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colors.kSecondaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.all(16),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.window_rounded,
                  size: 30,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    size: 35,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
