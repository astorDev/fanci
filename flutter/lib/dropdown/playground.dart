import 'package:fanci/dropdown/widgets.dart';
import 'package:flutter/material.dart';

import '../fanci_playground.dart';

void main() {
  runApp(DropdownPlaygroundApp());
}

class DropdownPlaygroundApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Dropdown',
      tabs: [
        PlaygroundTab(
          emoji: '🚥',
          label: 'One',
          page: FormPlayground(),
        ),
      ],
    );
  }
}

class FormPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Text Field',
                ),
              ),
            ),
            DropdownMenu(dropdownMenuEntries: [
              DropdownMenuEntry(
                label: 'USD',
                value: 'USD'
              ),
              DropdownMenuEntry(
                label: 'EUR',
                value: 'EUR'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
            ])
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Text Field',
                ),
              ),
            ),
            TextSelector(
              controller: TextSelectorController(
                options: ['USD', 'EUR', 'GBP'],
                selected: 'USD',
              ),
              headBuilder: (selected, opened) => TextSelectorHead(
                selected: selected,
                opened: opened,
              ),
              itemBuilder: (item) => TextSelectorItemView(item)
            ),
          ],
        ),
      ],
    );
  }
}

class TextSelectorHead extends StatelessWidget {
  final String selected;
  final bool opened;

  const TextSelectorHead({
    required this.selected,
    required this.opened,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(selected),
          SizedBox(width: 44),
          Text(opened ? '▲' : '▼')
        ],
      ),
    );
  }
}

class TextSelectorItemView extends StatelessWidget {
  final String value;

  const TextSelectorItemView(this.value);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).colorScheme.surfaceContainer;

    return InkWell(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(value),
      ),
    );
  }
  
}

class TextSelectorController extends ValueNotifier<String> {
  String get selected => value;
  final List<String> options;

  TextSelectorController({ 
    required this.options, 
    required String selected
  }) : super(selected);

  void select(String value) {
    if (value != this.value) {
      this.value = value;
    }
  }
}

class TextSelector extends StatelessWidget {
  final TextSelectorController controller;
  final Widget Function(String selected, bool opened) headBuilder;
  final Widget Function(String item) itemBuilder;

  const TextSelector({
    required this.controller,
    required this.headBuilder,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownBuilder(
      buttonBuilder: (BuildContext context, Function() onTap, bool opened) {
        return ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) => InkWell(
            onTap: onTap,
            child: headBuilder(value, opened),
             //Text(value + (opened ? '▲' : '▼')),
          )
        );
      },
      menuBuilder: (BuildContext context, Function() onItemTap) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var option in controller.options)
            InkWell(
              onTap: () {
                controller.select(option);
                onItemTap();
              },
              child: itemBuilder(option)
            ),
        ],
      ),
    );
  }
}