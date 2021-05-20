import 'package:flutter/material.dart';

class SelectDiceStyles {
  static TextStyle textButtonStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static BorderSide border = BorderSide(
    width: 1.0,
    color: Colors.white.withOpacity(0.85),
  );

  static BoxDecoration tileBoxStyle = BoxDecoration(
    border: Border(
      top: SelectDiceStyles.border,
      bottom: SelectDiceStyles.border,
      right: SelectDiceStyles.border,
      left: SelectDiceStyles.border,
    ),
    borderRadius: BorderRadius.circular(20),
    color: Colors.white.withOpacity(0.5),
  );
}