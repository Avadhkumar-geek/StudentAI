import 'package:flutter/material.dart';

class ChatBubble extends CustomPainter {
  final Color bgColor;

  ChatBubble(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(5, 0);
    path.lineTo(0, -10);
    path.lineTo(-5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
