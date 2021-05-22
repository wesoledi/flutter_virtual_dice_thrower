import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:virtual_dice/dictionaries/dices_special_rpg.dart';

class SelectDiceRpgPage extends StatelessWidget {
  SelectDiceRpgPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('selection.rpg').tr(),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: generateItems(context),
        ),
      ),
    );
  }

  List<Widget> generateItems(BuildContext context) {
    TextStyle listViewItemTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    );

    return List.generate(dicesSpecialRpg.length, 
      (index) => Container(
        height: 50,
        child: Center(
          child: TextButton(
            child:Text(dicesSpecialRpg[index].name, style: listViewItemTextStyle).tr(),
            onPressed: () { onTap(context, dicesSpecialRpg[index].route); },
          ),
        ),
      )
    );
  }

  void onTap(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}