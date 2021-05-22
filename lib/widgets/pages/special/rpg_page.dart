import 'dart:math';
import 'package:flutter/material.dart';
import 'package:virtual_dice/dictionaries/types/named_route.dart';
import 'package:wakelock/wakelock.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:virtual_dice/variables/dices_listview_results_styles.dart';
import 'package:virtual_dice/widgets/pages/special/special_mixins.dart';

class RpgPage extends StatefulWidget {
  RpgPage({
    Key key, 
    this.titleKey,
    this.defaultDiceMaxValue = 100,
    this.showBottomNavigationBar = true,
    this.diceSelectionItems,
  }) : super(key: key);

  final String titleKey;
  final int defaultDiceMaxValue;
  final bool showBottomNavigationBar;
  final List<NamedRoute> diceSelectionItems;

  @override
  _RpgPageState createState() => _RpgPageState();
}

class _RpgPageState extends State<RpgPage> with SpecialPageMixin {
  final List<int> results = [];
  final List<String> resultsPerDice = [];
  final List<Color> resultsPerDiceColors = [];
  bool gotBonusDice = false;
  bool gotPenaltyDice = false;
  int diceMaxValue;
  int numOfDices = 1;
  NamedRoute selectedDice;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();

    diceMaxValue = widget.defaultDiceMaxValue;
    selectedDice = widget.diceSelectionItems.reduce((value, element) => 
      element.route == widget.defaultDiceMaxValue.toString()
        ? element
        : null
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBuild(
      titleKey: widget.titleKey,
      getBody: getBody,
      getBottomNavigation: getBottomNavigation,
      bottomNavigationItems: getBottomNavigationItems(),
      getFloatButton: getFloatButton,
    );
  }

  Widget getBottomNavigation() {
    if (!widget.showBottomNavigationBar) {
      return null;
    }
    return getBottomNavigationBar(
      context: context,
      items: getBottomNavigationItems(),
      onTapIndex0: () { if (selectedDice.params[0].gotModifiers) addBonusDice(); },
      onTapIndex1: () { if (selectedDice.params[0].gotModifiers) addPenaltyDice(); }
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationItems() {
    List<BottomNavigationBarItem> buttonNavigationItems = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.sentiment_satisfied_outlined,
          color: gotBonusDice ? Colors.green : Theme.of(context).primaryColor
        ),
        label: 'rpg.bonus'.tr(),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.sentiment_dissatisfied_outlined,
          color: gotPenaltyDice ? Colors.red : Theme.of(context).primaryColor
        ),
        label: 'rpg.penalty'.tr(),
      ),
    ];

    if (diceMaxValue != 100) {
      buttonNavigationItems = getBottomNavigationItemsEmpty();
    }

    return buttonNavigationItems;
  }

  Widget getFloatButton() {
    Color color = Theme.of(context).primaryColor;
    if (gotBonusDice) color = Colors.green;
    if (gotPenaltyDice) color = Colors.red;

    Widget floatingWidget = widget.showBottomNavigationBar 
      ? getFloatingButtonWithColor(
        color: color,
        onPressed: () { roll(); }
      )
      : getTwoFloatingButtonWithColor(
        color: color,
        onPressed1: () { roll(); },
        onPressed2: () { clear(); },
      );

    return Padding(
      child: floatingWidget,
      padding: widget.showBottomNavigationBar ? EdgeInsets.zero : EdgeInsets.only(bottom: 20),
    );
  }

  Widget getBody() {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenSize.width / 2,
            height: screenSize.height,
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) { return getListViewItems(context, index); },
            ),
          ),
          getDiceSelectionSection(
            buttonsDicesGenerator: getDiceSelectionButtonGenerator(
              items: widget.diceSelectionItems,
              screenSize: screenSize,
            ),
            screenSize: screenSize,
            currentSelection: diceMaxValue,
            onSelect: (v, idx) {setDiceMaxValue(int.parse(v), index: idx);},
            topTextSuffix: numOfDices > 1 ? 'x' + numOfDices.toString() : ''
          ),
        ]
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

  void setDiceMaxValue(int value, {int index = 0}) {
    setState(() {
      selectedDice = widget.diceSelectionItems[index];

      if (value == diceMaxValue && selectedDice.params[0].mayRise) {
        numOfDices++;
        return;
      } else {
        numOfDices = 1;
      }

      diceMaxValue = value;

      results.clear();
      resultsPerDice.clear();
      resultsPerDiceColors.clear();

      gotBonusDice = false;
      gotPenaltyDice = false;
    });
  }

  void roll() {
    if (!gotBonusDice && !gotPenaltyDice) {
      rollWithNoBonuses();
    } else {
      rollWithBonuses();
    }
  }

  void rollWithNoBonuses() {
    var rnd = new Random();
    int totalResult = 0;
    List<int> partialResults = [];

    for (int i = 0; i < numOfDices; i++) {
      int partialResult = 1 + rnd.nextInt(diceMaxValue); 
      totalResult += partialResult;
      partialResults.add(partialResult);
    }

    setState(() {
      results.insert(0, totalResult);
      resultsPerDice.insert(0, numOfDices > 1 ? partialResults.join(' + ') : '');
      resultsPerDiceColors.insert(0, numOfDices > 1 ? Colors.blue : Colors.black);
    });
  }

  void rollWithBonuses() {
    var rnd = new Random();
    int firstRoll = 1 + rnd.nextInt(diceMaxValue); 
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

  void clear() {
    setState(() {
      results.clear();
      resultsPerDice.clear();
      resultsPerDiceColors.clear();
      numOfDices = 1;
    });
  }
}