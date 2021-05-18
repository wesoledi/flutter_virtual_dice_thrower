import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:virtual_dice/services/router.dart';

void main() async {
  // runApp(SimpleVirtualDiceApp());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('pl')],
      path: 'assets/translations', 
      fallbackLocale: Locale('en'),
      child: SimpleVirtualDiceApp()
    )
  );
}

class SimpleVirtualDiceApp extends StatelessWidget {
  final title = "Virtual Dice Thrower";
  @override
  Widget build(BuildContext context) {
    // context.locale = Locale('en');
    return MaterialApp(
      title: 'Virtual Dice Thrower',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // routes: {
      //   '/': (context) => HomePage(title: title),
      //   '/select_dice': (context) => SelectDicePage(title: title),
      //   '/info': (context) => InfoPage(title: title),
      // },
      onGenerateRoute: (settings) {
        return DiceRouter.getRoutings(settings: settings, title: title);
      },
    );
  }
}


