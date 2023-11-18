import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_ai/data/constants/constants.dart';

class DummyForm extends StatelessWidget {
  final String title;

  const DummyForm({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF9A9797),
          Color(0xFFF4F4F4),
          Color(0xFF9A9797),
        ],
        begin: Alignment.topLeft,
        end: Alignment(2.0, 0.3),
        stops: [
          0.2,
          0.3,
          0.4,
        ],
        tileMode: TileMode.mirror,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          for (var i = 0; i < 4; i++)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF9A9797),
                        ),
                        height: 22,
                        width: 48,
                      )),
                  Container(
                    height: 53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF9A9797),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
