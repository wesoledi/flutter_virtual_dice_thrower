import 'package:flutter/material.dart';
import 'package:virtual_dice/services/grid/dice_generator.dart';
import 'package:virtual_dice/widgets/components/frosted_glass_box.dart';

class SelectDicePage extends StatelessWidget {
  SelectDicePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double gridChildSize = screenSize.width / 3 - 20;

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
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FrostedGlassBox(
                  child: GridView.count(
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: DiceItemsGenerator.getItems(
                      childSize: gridChildSize,
                      onTap: (route) { goToDice(context, route); }
                    ),
                  ),
                  width: screenSize.width - 20,
                  height: gridChildSize * 2 + 20 + 10,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  void goToDice(context, link) {
    Navigator.pushNamed(context, link);
  }
}