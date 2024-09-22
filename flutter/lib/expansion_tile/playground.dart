import 'package:fanci/fanci_playground.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyPlaygroundApp());
}

class MyPlaygroundApp extends StatelessWidget {
  const MyPlaygroundApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Expansion Tile',
      tabs: [
        PlaygroundTab(
          emoji: '🚥', 
          label: 'Problem', 
          page: ProblemCase()
        ),
      ],
    );
  }
}

class Accessor {
  static Uuid uuid = Uuid();

  static final collection = CollectionController<String>(
    List.generate(3, (index) => uuid.v4())..shuffle()
  );

  static void remove(String itemValue) {
    collection.remove(itemValue);
  }

  static void add() {
    collection.add(uuid.v4());
  }
}

class ProblemCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Accessor.collection,
      builder: (context, items, child) => Column(
        children: [
          TextButton(
            onPressed: Accessor.add,
            child: Text('Add new item')
          ),
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

  void remove(T itemValue) {
    var updated = List<T>.from(value);
    updated.shuffle();
    updated.remove(itemValue);

    value = updated;
    notifyListeners();
  }

  void add(T addedItem) {
    var updated = List<T>.from(value);
    updated.add(addedItem);

    value = updated;
    notifyListeners();
  }
}

class TileAtIndex extends StatefulWidget {
  final String index;
  final Function(String index) onRemoveMeTap;
  
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
      title: Text('Tile #${widget.index}'),
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