import 'package:flutter/material.dart';
import 'package:virtual_dice/dictionaries/types/named_route.dart';
import 'package:virtual_dice/services/grid/dice_selection_generator.dart';
import 'package:virtual_dice/widgets/components/frosted_glass_box.dart';
import 'package:virtual_dice/variables/select_dice_styles.dart';
import 'package:virtual_dice/services/grid/buttons_generator.dart';

class SelectDicePage extends StatelessWidget {
  SelectDicePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double gridChildSize = screenSize.width / 3 - 20;

    var buttonMoreGenerator = new ButtonsGenerator();
    buttonMoreGenerator.setChildSize(screenSize.width / 2 - 20, 40);
    buttonMoreGenerator.setTextButtonStyle(SelectDiceStyles.textButtonStyle);
    buttonMoreGenerator.setTileBoxDecoration(SelectDiceStyles.tileBoxStyle);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrostedGlassBox(
                  child: GridView.count(
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                    children: DiceSelectionItemsGenerator.getItems(
                      childSize: gridChildSize,
                      onTap: (route, idx) { goToDice(context, route); }
                    ),
                  ),
                  width: screenSize.width - 20,
                  height: gridChildSize * 2 + 20 + 25,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                FrostedGlassBox(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: buttonMoreGenerator.getButton(
                        NamedRoute(name: 'selection.more', route: ''), 
                        onTap: (p, idx) { goToAdditionalSelection(context); },
                      ),
                    ),
                  ),
                  width: screenSize.width / 2,
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  void goToDice(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  void goToAdditionalSelection(BuildContext context) {
    Navigator.pushNamed(context, '/select_dice_rpg');
  }
}