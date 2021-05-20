import 'package:flutter/material.dart';
import 'package:virtual_dice/dictionaries/dices.dart';
import 'package:virtual_dice/variables/select_dice_styles.dart';

class DiceSelectionItemsGenerator {
  static List<Widget> getItems({double childSize, onTap}) {
    return List.generate(dices.length, 
      (index) => Center(
        child: Container(
          width: childSize,
          height: childSize,
          child: DecoratedBox(
            decoration: SelectDiceStyles.tileBoxStyle,
            child: TextButton(
              child: Text(dices[index].name, style: SelectDiceStyles.textButtonStyle),
              onPressed: () { onTap(dices[index].route); },
            ),
          ),
        ),
      ),
    );
  }
}