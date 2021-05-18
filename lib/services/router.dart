import 'package:flutter/material.dart';

import 'package:virtual_dice/widgets/pages/home.dart';
import 'package:virtual_dice/widgets/pages/select_dice.dart';
import 'package:virtual_dice/widgets/pages/dice.dart';
import 'package:virtual_dice/widgets/pages/info.dart';
import 'package:virtual_dice/widgets/pages/error.dart';

class DiceRouter {
  static getRoutings({settings, title}) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => HomePage(title: title));
    }

    if (settings.name == '/select_dice') {
      return MaterialPageRoute(builder: (context) => SelectDicePage(title: title));
    }

    if (settings.name == '/info') {
      return MaterialPageRoute(builder: (context) => InfoPage(title: title));
    }

    // Handle '/dices/:id'
    var uri = Uri.parse(settings.name);
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'dices') {
      int id = int.parse(uri.pathSegments[1]);
      return MaterialPageRoute(builder: (context) => DicePage(id: id));
    }

    return MaterialPageRoute(builder: (context) => ErrorPage());
  }
}