import 'package:fanci/fanci_playground.dart';
import 'package:fanci/mock_column.dart';
import 'package:fanci/sliding_playground.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          page: TabsShowcases()
        ),
        FanciPlaygroundTab(
          emoji: '🏃', 
          label: 'Slide',
          page: SlidingShowcase()
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



class TabsShowcases extends StatelessWidget {
  const TabsShowcases({
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

class CustomTabsView extends StatefulWidget  {
  @override
  State<CustomTabsView> createState() => _CustomTabsViewState();
}

class TabSelection {
  final int current;
  final int? previous;

  TabSelection(this.current, this.previous);
}

class TabSelectionController extends ChangeNotifier implements ValueListenable<TabSelection> {
  
  TabSelection _value = TabSelection(0, null);
  @override
  TabSelection get value => _value;

  void select(int tabIndex) {
    _value = TabSelection(tabIndex, _value.current);
    notifyListeners();
  }
}

class _CustomTabsViewState extends State<CustomTabsView> with SingleTickerProviderStateMixin {
  var selectionController = TabSelectionController();
  late final AnimationController slideController = AnimationController(
    duration: kTabScrollDuration,
    vsync: this,
  );

  Widget getChild(int index) {
    if (index == 0) return CarMockColumn();
    if (index == 1) return TransitMockColumn();
    if (index == 2) return BikeMockColumn();

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => selectionController.select(0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Icon(Icons.directions_car),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => selectionController.select(1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Expanded(child: Icon(Icons.directions_transit)),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => selectionController.select(2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Expanded(child: Icon(Icons.directions_bike)),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          color: Colors.orange,
        ),
        ValueListenableBuilder(
          valueListenable: selectionController,
          builder: (context, selection, child) {
            if (selection.previous == null) {
              return getChild(selection.current);
            }

            slideController.forward(from: 0);
            
            return StandardSliding(
              direction: selection.current > selection.previous! ? SlideDirection.left : SlideDirection.right, 
              animationController: slideController, 
              child: getChild(selection.current),
            );
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
            height: 150,
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