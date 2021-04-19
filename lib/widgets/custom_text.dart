import 'package:sync_biryani_web/helpers/commans.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color colors;
  final FontWeight weight;
  final TextAlign align;

  const CustomText(
      {@required this.text, this.size, this.colors, this.weight, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
          fontSize: size ?? 16,
          color: colors ?? black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
