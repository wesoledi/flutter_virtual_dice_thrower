import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wakelock/wakelock.dart';
import 'package:virtual_dice/variables/dices_listview_results_styles.dart';

class DicePage extends StatefulWidget {
  DicePage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  final List<int> results = [];
  final List<String> resultsPerDice = [];
  int numOfDices = 1;
  bool showModalToChooseDiceNumber = false;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dice.appBar').tr(namedArgs: {
          "size": widget.id.toString(),
          "multiplier": numOfDices.toString(),
        }),
      ),
      body: getBody(),
      bottomNavigationBar: getBottomNavigation(),
      floatingActionButton: getFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBottomNavigation() {
    if (showModalToChooseDiceNumber) {
      return null;
    }
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.clear),
          label: 'dice.clear'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'dice.moreDice'.tr(),
        ),
      ],
      onTap: (index) {
        if (index == 0) { clearList(); }
        if (index == 1) { selectMoreDiceAtOnce(); }
      }
    );
  }

  Widget getFloatButton() {
    if (showModalToChooseDiceNumber) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () { roll(); },
      tooltip: 'dice.roll'.tr(),
      child: const Icon(Icons.refresh),
    );
  }

  Widget getBody() {
    Size screenSize = MediaQuery.of(context).size;

    if (showModalToChooseDiceNumber) {
      return getModalToChooseDiceNumber();
    }

    return Stack(
      children: [
        Container(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) { return getListViewItems(context, index); },
          ),
        ),
        getSummaryOfRolling(screenSize),
      ],
    );
  }

  Widget getSummaryOfRolling(Size screenSize) {
    return Positioned(
      top: 85,
      right: 20,
      child: Container(
        width: screenSize.width / 2 - 20,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getFloatingBoxContent(results),
        ),
      ),
    );
  }

  Widget getModalToChooseDiceNumber() {
    if (!showModalToChooseDiceNumber) {
      return null;
    }

    TextStyle choosenNumOfDiceStyle = TextStyle(
      fontSize: 28,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    double buttonSize = 32;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(numOfDices.toString(), style: choosenNumOfDiceStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlinedButton(
                child: Icon(Icons.add_circle_outline, size: buttonSize),
                onPressed: () { setState(() { numOfDices++; }); }
              ),
              OutlinedButton(
                child: Icon(Icons.remove_circle_outline, size: buttonSize),
                onPressed: () { setState(() { numOfDices--; }); }
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: Icon(Icons.check),
              label: Text(
                'dice.saveDices',
                style: TextStyle(fontSize: 18),
              ).tr(),
              onPressed: () { setState(() { showModalToChooseDiceNumber = false; }); },
            ),
          ),
        ],
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
        child: Text(
          getItemValue(index), 
          style: index == 0 
            ? DicesListViewResultsStyles.resultTopTextStyle.copyWith(
              color: Theme.of(context).primaryColor
            )
            : DicesListViewResultsStyles.resultTextStyle
        ),
      ),
    );
  }

  String getItemValue(int index) {
    if (numOfDices == 1) {
      return results[index].toString();
    }

    return resultsPerDice[index] + ' = ' + results[index].toString();
  }

  List<Widget> getFloatingBoxContent(List<int> results) {
    TextStyle textStyle = TextStyle(
      fontSize: 16,
      color: Colors.black.withOpacity(0.75),
    );
    int resultsSumUp = results.length > 0 
      ? results.reduce((value, element) => value + element)
      : 0;

    return <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 20, top: 10), 
        child: Text('dice.resultsCount', style: textStyle)
          .tr(namedArgs: {"count": results.length.toString()})
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, top: 5), 
        child: Text('dice.resultsSum', style: textStyle)
          .tr(namedArgs: {"sum": resultsSumUp.toString()})
      ),
    ];
  }

  void clearList() {
    setState(() {
      results.clear();
    });
  }

  void selectMoreDiceAtOnce() {
    setState(() {
      showModalToChooseDiceNumber = true;
    });
  }

  void roll() {
    var rnd = new Random();
    int totalResult = 0;
    List<int> partialResults = [];

    for (int i = 0; i < numOfDices; i++) {
      int partialResult = 1 + rnd.nextInt(widget.id); 
      totalResult += partialResult;
      partialResults.add(partialResult);
    }

    setState(() {
      results.insert(0, totalResult);
      resultsPerDice.insert(0, partialResults.join(' + '));
    });
  }
}