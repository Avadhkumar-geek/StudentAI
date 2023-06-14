import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/support_card.dart';

class RateCard extends StatefulWidget {
  const RateCard({super.key});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  double _rating = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: kBlack,
            title: const Text(
              "Rate Us",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: kWhite),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Colors.grey[400],
                  itemCount: 5,
                  itemSize: 40.0,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                  updateOnDrag: true,
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: kGrey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: kButtonColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const SupportCard(
        title: "Rate Us",
        disc: "Review on PlayStore",
        imgSrc: "assets/rate.svg",
        color: kSupportCard2,
      ),
    );
  }
}
