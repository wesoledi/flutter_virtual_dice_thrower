import 'package:flutter/material.dart';

import 'package:virtual_dice/widgets/pages/home.dart';
import 'package:virtual_dice/widgets/pages/select_dice.dart';
import 'package:virtual_dice/widgets/pages/select_dice_rpg.dart';
import 'package:virtual_dice/widgets/pages/dice.dart';
import 'package:virtual_dice/widgets/pages/info.dart';
import 'package:virtual_dice/widgets/pages/error.dart';

import 'package:virtual_dice/services/widget_factory/dice_special_factory.dart';

class DiceRouter {
  static getRoutings({settings, title}) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => HomePage(title: title));
    }

    if (settings.name == '/select_dice') {
      return MaterialPageRoute(builder: (context) => SelectDicePage(title: title));
    }

    if (settings.name == '/select_dice_rpg') {
      return MaterialPageRoute(builder: (context) => SelectDiceRpgPage(title: title));
    }

    if (settings.name == '/info') {
      return MaterialPageRoute(builder: (context) => InfoPage(title: title));
    }

    var uri = Uri.parse(settings.name);

    // Handle '/dices/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'dices') {
      int id = int.parse(uri.pathSegments[1]);
      return MaterialPageRoute(builder: (context) => DicePage(id: id));
    }

    // Handle '/special/:handler'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'special') {
      String handler = uri.pathSegments[1];
      return MaterialPageRoute(builder: (context) => DiceSpecialFactory(handler: handler));
    }

    return MaterialPageRoute(builder: (context) => ErrorPage());
  }
}