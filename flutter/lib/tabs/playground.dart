import 'package:fanci/fanci_playground.dart';
import 'package:fanci/mock_column.dart';
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
                CustomTabView(
                  children: [
                    MockColumn(),
                    MockColumn(height: 10,),
                    MockColumn(height: 7,)
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
                      MockColumn(),
                      MockColumn(height: 10,),
                      MockColumn(height: 7)
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

class CustomTabView extends StatelessWidget {
  final List<Widget> children;

  const CustomTabView({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    var controller = DefaultTabController.of(context);
    
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return children[controller.index];
      }
    );
  }
}