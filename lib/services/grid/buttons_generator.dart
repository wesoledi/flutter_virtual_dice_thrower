import 'package:flutter/material.dart';
import 'package:virtual_dice/dictionaries/types/named_route.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonsGenerator {
  ButtonsGenerator({Key key, this.items}) : super();

  final List<NamedRoute> items;
  double _buttonWidth = 50;
  double _buttonHeight = 30;
  double _spacing = 0;
  BoxDecoration _tileBoxDecoration = BoxDecoration();
  TextStyle _textButtonStyle = TextStyle();

  void setChildSize(double newWidth, double newHeight) {
    _buttonWidth = newWidth;
    _buttonHeight = newHeight;
  }

  void setTileBoxDecoration(BoxDecoration newStyle) {
    _tileBoxDecoration = newStyle;
  }

  void setTextButtonStyle(TextStyle newStyle) {
    _textButtonStyle = newStyle;
  }

  void putSpacingBoxBeetween(double size) {
    _spacing = size;
  }

  List<Widget> getButtons({onTap}) {
    return List.generate(
      items.length, 
      (index) => getButton(items[index], onTap: onTap, index: index)
    );
  }

  Widget getButton(item, {onTap, index}) {
    return Column(
      children: [
        Container(
          width: _buttonWidth,
          height: _buttonHeight,
          child: DecoratedBox(
            decoration: _tileBoxDecoration,
            child: TextButton(
              child: Text(item.name, style: _textButtonStyle).tr(),
              onPressed: () { onTap(item.route, index); },
            ),
          ),
        ),
        if (_spacing > 0) SizedBox(height: _spacing,)
      ],
    );
  }
  
}