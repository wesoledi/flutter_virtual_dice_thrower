import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:virtual_dice/dictionaries/dices_special.dart';

class SelectDiceMorePage extends StatelessWidget {
  SelectDiceMorePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('selection.appBar').tr(),
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

    return List.generate(dicesSpecial.length, 
      (index) => Container(
        height: 50,
        child: Center(
          child: TextButton(
            child:Text(dicesSpecial[index].name, style: listViewItemTextStyle).tr(),
            onPressed: () { onTap(context, dicesSpecial[index].route); },
          ),
        ),
      )
    );
  }

  void onTap(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}