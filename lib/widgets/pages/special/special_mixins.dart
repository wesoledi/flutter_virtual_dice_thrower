import 'dart:math';
import 'package:flutter/material.dart';
import 'package:virtual_dice/variables/colors.dart';
import 'package:wakelock/wakelock.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:virtual_dice/variables/dices_listview_results_styles.dart';
import 'package:virtual_dice/services/grid/buttons_generator.dart';
import 'package:virtual_dice/variables/select_dice_styles.dart';
import 'package:virtual_dice/widgets/pages/special/call_of_cthulhu/dices.dart';

mixin SpecialPageMixin {
  Widget getBuild({
    String titleKey, 
    getBody,
    getBottomNavigation,
    bottomNavigationItems,
    getFloatButton,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleKey).tr(),
      ),
      body: Container(
        child: getBody(),
      ),
      bottomNavigationBar: getBottomNavigation(),
      floatingActionButton: getFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationItemsEmpty() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.remove_circle_outline),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.remove_circle_outline),
        label: '',
      ),
    ];
  }

  BottomNavigationBar getBottomNavigationBar({
    BuildContext context,
    List<BottomNavigationBarItem> items,
    onTapIndex0,
    onTapIndex1
  }) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
      items: items,
      onTap: (index) {
        if (index == 0) { onTapIndex0(); }
        if (index == 1) { onTapIndex1(); }
      }
    );
  }

  FloatingActionButton getFloatingButtonWithColor({color, onPressed}) {
    return FloatingActionButton(
      onPressed: () { onPressed(); },
      tooltip: 'dice.roll'.tr(),
      child: const Icon(Icons.refresh),
      backgroundColor: color,
    );
  }

  Widget getTwoFloatingButtonWithColor({color, onPressed1, onPressed2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getFloatingButtonWithColor(color: color, onPressed: onPressed1),
        SizedBox(width: 20,),
        FloatingActionButton(
          onPressed: () { onPressed2(); },
          tooltip: 'dice.clear'.tr(),
          child: const Icon(Icons.clear),
          backgroundColor: color,
        ),
      ],
    );
  }

  ButtonsGenerator getDiceSelectionButtonGenerator({screenSize, items}) {
    ButtonsGenerator buttonsDicesGenerator = new ButtonsGenerator(items: items);
    buttonsDicesGenerator.setChildSize(screenSize.width / 3, 50);
    buttonsDicesGenerator.setTextButtonStyle(SelectDiceStyles.textButtonStyle);
    buttonsDicesGenerator.setTileBoxDecoration(SelectDiceStyles.tileBoxDarkBorderStyle);
    buttonsDicesGenerator.putSpacingBoxBeetween(10);

    return buttonsDicesGenerator;
  }

  Widget getDiceSelectionSection({
    screenSize,
    buttonsDicesGenerator,
    currentSelection,
    onSelect,
    topTextSuffix = '',
  }) {
    return Container(
      width: screenSize.width / 2,
      child: Column(
        children: [
          Text('dice.current').tr(),
          Text(
            'k' + currentSelection.toString() + ' ' + topTextSuffix, 
            style: DicesListViewResultsStyles.resultTopTextStyle
          ),
          Divider(),
          Column(
            children: 
              buttonsDicesGenerator.getButtons(onTap: onSelect),
          ),
        ],
      ),
    );
  }
}