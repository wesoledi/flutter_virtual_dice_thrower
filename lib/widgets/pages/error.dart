import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('info.appBar').tr(),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Center(
          child: Text(
            'error',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
            ).tr(),
        ),
      ),
    );
  }
}