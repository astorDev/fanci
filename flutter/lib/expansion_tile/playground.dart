import 'package:fanci/fanci_playground.dart';
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
      appName: 'Expansion Tile',
      tabs: [
        FanciPlaygroundTab(
          emoji: '🚥', 
          label: 'Problem', 
          page: ProblemCase()
        ),
      ],
    );
  }
}

class Accessor {
  static final collection = CollectionController<int>(List.generate(10, (index) => index));

  static void remove(int itemValue) {
    collection.remove(itemValue);
  }
}

class ProblemCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Accessor.collection,
      builder: (context, items, child) => Column(
        children: [
          for (var e in items)
            TileAtIndex(
              index: e,
              onRemoveMeTap: Accessor.remove,
            ),
        ],
      ),
    );
  }
}

class CollectionController<T> extends ValueNotifier<List<T>> {
  CollectionController(super.value);

  void remove(int itemValue) {
    value.remove(itemValue);
    notifyListeners();
  }
}

class TileAtIndex extends StatefulWidget {
  final int index;
  final Function(int index) onRemoveMeTap;
  
  const TileAtIndex({
    super.key,
    required this.index,
    required this.onRemoveMeTap,
  });

  @override
  State<TileAtIndex> createState() => _TileAtIndexState();
}

class _TileAtIndexState extends State<TileAtIndex> {
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
      title: Text('Tile #${widget.index + 1}'),
      children: [
        TextButton(
          onPressed: () {
            controller.collapse();
            widget.onRemoveMeTap(widget.index);
          }, 
          child: Text('Remove me')
        )
      ],
    );
  }
}