import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:virtual_dice/widgets/components/frosted_glass_box.dart';
import 'package:virtual_dice/widgets/components/button_simple.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/dices.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FrostedGlassBox(
                  width: screenSize.width * 0.8,
                  height: 240,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        this.getAppNameText(),
                        this.getActionButtons(context),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppNameText() {
    Color textColor = Colors.white.withOpacity(0.85);
    TextStyle mainTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textColor,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 4.0,
        ),
        Shadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 12.0,
        ),
      ],
    );

    Widget appText = Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "Virtual Dice",
          style: mainTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        appText,
        Divider(
          color: textColor,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }

  Widget getActionButtons(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenSize.width * 0.6,
          child: ButtonSimple(
            textKey: 'home.start',
            onTap: () { goToDiceSelection(context); },
          ),
        ),
        SizedBox(
          width: screenSize.width * 0.6,
          child: ButtonSimple(
            textKey: 'home.info',
            onTap: () { goToInformationSelection(context); },
          ),
        ),
      ],
    );
  }

  void goToDiceSelection(context) {
    Navigator.pushNamed(context, '/select_dice');
  }
  void goToInformationSelection(context) {
    Navigator.pushNamed(context, '/info');
  }
}