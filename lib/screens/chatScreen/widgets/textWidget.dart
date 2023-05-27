// ignore_for_file: file_names
import 'package:ask_gpt/constants/styles.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.msg,
    this.fontSize = 16,
    this.color,
    this.fontWeight,
  });

  final String msg;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(
        color: color ?? textColor,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
