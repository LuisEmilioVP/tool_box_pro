import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF83B4FF);
const Color secondaryColor = Color(0xFF5A72A0);
const Color textColor = Color(0xFF1A2130);
const Color backgroundColor = Color(0xFFF5F7F8);

const TextStyle titleStyle =
    TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold);

const TextStyle subtitleStyle =
    TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w300);

const TextStyle paragraphStyle = TextStyle(color: textColor, fontSize: 18);

final BoxDecoration boxDecoration = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(8),
  boxShadow: const [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
  ],
);
