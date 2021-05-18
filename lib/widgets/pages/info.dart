import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info/package_info.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: '???',
    packageName: '???',
    version: '???',
    buildNumber: '???',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title).tr(),
      subtitle: Text(subtitle.isNotEmpty ? subtitle : 'Not set'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('info.appBar').tr(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _infoTile('info.appName', _packageInfo.appName),
          _infoTile('info.packageName', _packageInfo.packageName),
          _infoTile('info.version', _packageInfo.version),
          _infoTile('info.build', _packageInfo.buildNumber),
        ],
      ),
    );

  }
}