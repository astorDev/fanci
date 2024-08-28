import 'package:flutter/material.dart';

class MockColumn extends StatelessWidget {
  final int height;
  final Widget Function(int)? itemBuilder;

  const MockColumn({
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