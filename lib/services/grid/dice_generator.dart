import 'package:flutter/material.dart';
import 'package:virtual_dice/dictionaries/dices.dart';


class DiceItemsGenerator {
  static List<Widget> getItems({double childSize, onTap}) {
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    BorderSide border = BorderSide(
      width: 1.0,
      color: Colors.white.withOpacity(0.85),
    );

    BoxDecoration decoration = BoxDecoration(
      border: Border(
        top: border,
        bottom: border,
        right: border,
        left: border,
      ),
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withOpacity(0.5),
    );
    return List.generate(dices.length, 
      (index) => Center(
        child: Container(
          width: childSize,
          height: childSize,
          child: DecoratedBox(
            decoration: decoration,
            child: TextButton(
              child: Text(dices[index].name, style: textStyle),
              onPressed: () { onTap(dices[index].route); },
              style: TextButton.styleFrom(
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}