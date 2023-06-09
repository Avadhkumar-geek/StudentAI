import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/quiz_model.dart';

class MCQ extends StatefulWidget {
  const MCQ(
      {Key? key,
      required this.mcq,
      required this.selectedOptions,
      required this.isSumitted,
      required this.index})
      : super(key: key);

  final int index;
  final Question mcq;
  final Map<int, String> selectedOptions;
  final bool isSumitted;
  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.mcq.question,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.mcq.options.length,
          itemBuilder: (context, index) {
            final option = widget.mcq.options[index];
            final isSelected = _selectedOption == option;
            return RadioListTile<String>(
              activeColor: kRadiumGreen,
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                option,
                style: const TextStyle(fontSize: 18, color: kWhite),
              ),
              subtitle: isSelected && widget.isSumitted
                  ? (widget.mcq.answer != _selectedOption
                      ? const Text(
                          'Wrong answer',
                          style: TextStyle(color: kRed),
                        )
                      : null)
                  : null,
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  widget.selectedOptions[widget.index] = _selectedOption!;
                });
                // print(_selectedOption);
              },
            );
          },
        )
      ],
    );
  }
}
