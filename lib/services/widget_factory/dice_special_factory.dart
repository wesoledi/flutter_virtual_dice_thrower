import 'package:flutter/material.dart';

import 'package:virtual_dice/widgets/pages/error.dart';
import 'package:virtual_dice/widgets/pages/special/call_of_cthulhu/k100.dart';

class DiceSpecialFactory extends StatelessWidget {
  DiceSpecialFactory({Key key, this.handler}) : super(key: key);

  final String handler;

  @override
  Widget build(BuildContext context) {
    if (this.handler == 'k100cthulhu') {
      return CallCthulhu100();
    }

    return ErrorPage();
  }
}