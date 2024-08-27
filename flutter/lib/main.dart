import 'package:fanci/fanci_playground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyPlaygroundApp());
}

class MyPlaygroundApp extends StatelessWidget {
  const MyPlaygroundApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FanciPlaygroundApp(
      appName: 'Fanci',
      tabs: [
        FanciPlaygroundTab(
          emoji: '📊', 
          label: 'Tabs',
          page: TabsContentColumn()
        ),
        FanciPlaygroundTab(
          emoji: '🍌', 
          label: 'Banana',
          page: Center(child: Text('Rage for Banana'))
        ),
        FanciPlaygroundTab(
          emoji: '🍊', 
          label: 'Orange',
          page: Center(child: Text('Cage for Orange'))
        ),
      ],
    );
  }
}

class TabsContentColumn extends StatelessWidget {
  const TabsContentColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Built-in Tabs'),
        SizedBox(height: 10),
        Card(
          child: BuiltInTabsView(),
        ),
        SizedBox(height: 20),
        Text('Custom Tabs:'),
        SizedBox(height: 10),
        Card(
          child: CustomTabsView(),
        ),
      ],
    );
  }
}

class CustomTabsView extends StatelessWidget {
  var tabIndexController = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => tabIndexController.value = 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.directions_car),
              ),
            ),
            InkWell(
              onTap: () => tabIndexController.value = 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.directions_transit),
              ),
            ),
            InkWell(
              onTap: () => tabIndexController.value = 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.directions_bike),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          color: Colors.orange,
        ),
        ValueListenableBuilder(
          valueListenable: tabIndexController,
          builder: (context, index, child) {
            if (index == 0) return CarMockColumn();
            if (index == 1) return TransitMockColumn();
            if (index == 2) return BikeMockColumn();

            return MockColumn();
          }
        )
      ]
    );
  }
}

class BikeMockColumn extends StatelessWidget {
  const BikeMockColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MockColumn(height: 7, itemBuilder: (i) => Text('Bike #$i'),);
  }
}

class TransitMockColumn extends StatelessWidget {
  const TransitMockColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MockColumn(height: 5, itemBuilder: (i) => Text('Transit #$i'),);
  }
}

class CarMockColumn extends StatelessWidget {
  const CarMockColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MockColumn(height: 3, itemBuilder: (i) => Text('Car #$i'),);
  }
}

class MockColumn extends StatelessWidget{
  int height;
  Widget Function(int)? itemBuilder;

  MockColumn({
    super.key,
    this.height = 5,
    this.itemBuilder
  });

  @override
  Widget build(BuildContext context) {
    var range = List<int>.generate(height, (i) => i + 1);
    var effectiveItemBuilder = itemBuilder ?? (i) => Text('Item #$i');

    return Column(
      children: range.map(effectiveItemBuilder).toList(),
    );
  }

}

class BuiltInTabsView extends StatelessWidget {
  const BuiltInTabsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: [
                CarMockColumn(),
                TransitMockColumn(),
                BikeMockColumn()
              ],
            ),
          ),
        ],
      )
    );
  }
}