import 'package:fanci/fanci_playground.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TabsPlaygroundApp());
}

class TabsPlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FanciPlaygroundApp(
      appName: 'Tabs',
      tabs: [
        FanciPlaygroundTab(
          emoji: '🚥', 
          label: 'Main', 
          page: MainTabsPlayground()
        )
      ],
    );
  }
}

class MainTabsPlayground extends StatelessWidget {
  final GlobalKey _greenBoxKey = GlobalKey();
  final GlobalKey _orangeBoxKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: _greenBoxKey,
          width: 100,
          height: 100,
          color: Colors.green,
        ),
        Container(
          key: _orangeBoxKey,
          color: Colors.orange,
          padding: EdgeInsets.all(10),
          child: Text('Hello Orange'),
        ),
        TextButton(
          onPressed: () {
            print(_greenBoxKey.currentContext!.size);
            print(_orangeBoxKey.currentContext!.size);
          }, 
          child: Text('Print Sizes')
        )
      ]
    );
  }

}