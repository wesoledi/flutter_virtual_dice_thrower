import 'package:flutter/material.dart';

import 'package:virtual_dice/widgets/pages/error.dart';
import 'package:virtual_dice/widgets/pages/special/rpg_page.dart';
import 'package:virtual_dice/widgets/pages/special/call_of_cthulhu/dices.dart';
import 'package:virtual_dice/widgets/pages/special/dungeon_and_dragons/dices.dart';

class DiceSpecialFactory extends StatelessWidget {
  DiceSpecialFactory({Key key, this.handler}) : super(key: key);

  final String handler;

  @override
  Widget build(BuildContext context) {
    if (this.handler == 'cthulhu') {
      return RpgPage(
        titleKey: 'cthulhu.appBar',
        diceSelectionItems: cthultuWeaponDices,
        showBottomNavigationBar: true,
        defaultDiceMaxValue: 100,
      );
    }

    if (this.handler == 'dnd') {
      return RpgPage(
        titleKey: 'dnd.appBar',
        diceSelectionItems: dndWeaponDices,
        showBottomNavigationBar: false,
        defaultDiceMaxValue: 20,
      );
    }

    return ErrorPage();
  }
}