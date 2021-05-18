import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonSimple extends StatelessWidget {
  final onTap;
  final String textKey;
  final double scaleRatio;

  const ButtonSimple({
    @required this.textKey,
    @required this.onTap,
    this.scaleRatio = 1.0,
    }) : super();

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    ButtonStyle buttonStyle = OutlinedButton.styleFrom( 
      backgroundColor: Colors.white,
      padding: EdgeInsets.all(10.0 * this.scaleRatio),
    
    );

    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(textKey, style: buttonTextStyle).tr(),
        style: buttonStyle,
      ),
    );
  }
}