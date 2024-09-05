import 'package:fanci/fanci_playground.dart';
import 'package:fanci/tabs/lib.dart';
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
          emoji: '😎', 
          label: 'Main',
          page: Main()
        ),
        FanciPlaygroundTab(
          emoji: '🎨', 
          label: 'Built-In',
          page: BuiltInTabsPlayground()
        ),
        FanciPlaygroundTab(
          emoji: '📏', 
          label: 'Measurements', 
          page: Measurements()
        ),
      ],
    );
  }
}

class Measurements extends StatelessWidget {
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
        ),
      ]
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: DefaultTabController(
            length: 3, 
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.directions_car)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_bike)),
                  ]
                ),
                TabContentView(
                  children: [
                    MockColumn(5),
                    MockColumn(10),
                    MockColumn(7)
                  ],
                ),
              ]
            )
          ),
        ),
      ],
    );
  }
}

class BuiltInTabsPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: DefaultTabController(
            length: 3, 
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.directions_car)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_bike)),
                  ]
                ),
                SizedBox( 
                  height: 220.0, // Commenting the height out will produce an error (Failed assertion: 'hasSize')
                  child: TabBarView(
                    children: [
                      MockColumn(5),
                      MockColumn(10),
                      MockColumn(7)
                    ]
                  ),
                )
              ]
            )
          ),
        ),
      ],
    );
  }
}

class MockColumn extends StatelessWidget {
  final int itemCount;

  const MockColumn(this.itemCount);

  @override
  Widget build(BuildContext context) {
    var range = List<int>.generate(itemCount, (i) => i + 1);

    return Column(
      children: range.map((i) => Text('Item #$i')).toList(),
    );
  }
}