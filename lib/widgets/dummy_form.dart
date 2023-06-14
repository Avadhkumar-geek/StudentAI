import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';

class DummyForm extends StatelessWidget {
  final String title;

  const DummyForm({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        for (var i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFF524848),
                      ),
                      height: 22,
                      width: 48,
                    )),
                Container(
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF524848),
                  ),
                )
              ],
            ),
          ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 48,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF524848),
          ),
        )
      ],
    );
  }
}
