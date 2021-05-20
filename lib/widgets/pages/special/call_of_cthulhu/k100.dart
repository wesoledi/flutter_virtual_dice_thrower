import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:virtual_dice/variables/dices_listview_results_styles.dart';

class CallCthulhu100 extends StatefulWidget {
  CallCthulhu100({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _CallCthulhu100State createState() => _CallCthulhu100State();
}

class _CallCthulhu100State extends State<CallCthulhu100> {
  final List<int> results = [];
  final List<String> resultsPerDice = [];
  final List<Color> resultsPerDiceColors = [];
  bool gotBonusDice = false;
  bool gotPenaltyDice = false;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cthulhu.appBar').tr(),
      ),
      body: Container(
        child: getBody(),
      ),
      bottomNavigationBar: getBottomNavigation(),
      floatingActionButton: getFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.casino_outlined,
            color: gotBonusDice ? Colors.green : Theme.of(context).primaryColor
          ),
          label: 'cthulhu.bonus'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.casino_outlined,
            color: gotPenaltyDice ? Colors.red : Theme.of(context).primaryColor
          ),
          label: 'cthulhu.penalty'.tr(),
        ),
      ],
      onTap: (index) {
        if (index == 0) { addBonusDice(); }
        if (index == 1) { addPenaltyDice(); }
      }
    );
  }

  Widget getFloatButton() {
    Color color = Theme.of(context).primaryColor;

    if (gotBonusDice) {
      color = Colors.green;
    }
    if (gotPenaltyDice) {
      color = Colors.red;
    }

    return FloatingActionButton(
      onPressed: () { roll(); },
      tooltip: 'dice.roll'.tr(),
      child: const Icon(Icons.refresh),
      backgroundColor: color,
    );
  }

  Widget getBody() {
    return Container(
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) { return getListViewItems(context, index); },
      ),
    );
  }

  Widget getListViewItems(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(10),
      color: index == 0 
        ? Theme.of(context).primaryColor.withOpacity(0.2)
        : Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              results[index].toString(), 
              style: index == 0 
                ? DicesListViewResultsStyles.resultTopTextStyle.copyWith(
                  color: resultsPerDiceColors[index]
                )
                : DicesListViewResultsStyles.resultTextStyle.copyWith(
                  color: resultsPerDiceColors[index]
                )
            ),
            if (resultsPerDice[index] != '') 
              Text(
                resultsPerDice[index],
                style: DicesListViewResultsStyles.resultTinyTextStyle
              ),
          ],
        ),
      ),
    );
  }

  void addBonusDice() {
    setState(() {
      gotBonusDice = !gotBonusDice;
      gotPenaltyDice = false;
    });
  }

  void addPenaltyDice() {
    setState(() {
      gotPenaltyDice = !gotPenaltyDice;
      gotBonusDice = false;
    });
  }

  void roll() {
    var rnd = new Random();

    int firstRoll = 1 + rnd.nextInt(100); 

    if (!gotBonusDice && !gotPenaltyDice) {
      setState(() {
        results.insert(0, firstRoll);
        resultsPerDice.insert(0, '');
        resultsPerDiceColors.insert(0, Colors.black);
      });
      debugPrint('Rolled with no bonuses: ' + firstRoll.toString());
      debugPrint('Got results: ' + results.length.toString());
      return;
    }

    int secondRoll = 1 + rnd.nextInt(100); 

    int choosen = firstRoll;
    Color secondDiceColor = Colors.black;

    if (gotBonusDice) {
      choosen = firstRoll < secondRoll ? firstRoll : secondRoll;
      secondDiceColor = Colors.green;
    }

    if (gotPenaltyDice) {
      choosen = firstRoll > secondRoll ? firstRoll : secondRoll;
      secondDiceColor = Colors.red;
    }

    setState(() {
      results.insert(0, choosen);
      resultsPerDice.insert(0, firstRoll.toString() + ' & ' + secondRoll.toString());
      resultsPerDiceColors.insert(0, secondDiceColor);
      gotBonusDice = false;
      gotPenaltyDice = false;
    });
  }
}