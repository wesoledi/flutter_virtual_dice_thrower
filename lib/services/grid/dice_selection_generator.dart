import 'package:flutter/material.dart';
import 'package:virtual_dice/dictionaries/dices.dart';
import 'package:virtual_dice/variables/select_dice_styles.dart';
import 'package:virtual_dice/services/grid/buttons_generator.dart';

class DiceSelectionItemsGenerator {
  static List<Widget> getItems({double childSize, onTap}) {
    var buttonGenerator = new ButtonsGenerator(items: dices);
    buttonGenerator.setChildSize(childSize, childSize - 7.5);
    buttonGenerator.setTextButtonStyle(SelectDiceStyles.textButtonStyle);
    buttonGenerator.setTileBoxDecoration(SelectDiceStyles.tileBoxStyle);

    return buttonGenerator.getButtons(onTap: onTap);
  }
}