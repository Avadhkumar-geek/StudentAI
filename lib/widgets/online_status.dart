import 'package:flutter/material.dart';
import 'package:student_ai/widgets/indicator.dart';

class OnlineStatus extends StatefulWidget {
  final bool isOnline;
  const OnlineStatus({
    super.key,
    required this.isOnline,
  });

  @override
  State<OnlineStatus> createState() => _OnlineStatusState();
}

class _OnlineStatusState extends State<OnlineStatus> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.isOnline?"online":"Offline",
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 8,
          ),
          Indicator(status: widget.isOnline)
        ],
      ),
    );
  }
}
