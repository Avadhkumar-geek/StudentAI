import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';

class Indicator extends StatefulWidget {
  const Indicator({
    Key? key,
    required this.status,
  }) : super(key: key);

  final bool status;

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 8,
        maxHeight: 8,
      ),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.status ? successColor : errorColor,
      ),
    );
  }
}
