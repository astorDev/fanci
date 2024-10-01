import 'package:fanci/dropdown/effective_playground.dart';
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
          emoji: '🚦',
          label: 'Effective',
          page: EffectivePlayground(),
        ),
        PlaygroundTab(
          emoji: '🚥',
          label: 'Reference',
          page: FormPlayground(),
        ),
        PlaygroundTab(
          emoji: '🎨',
          label: 'InkWell with Container', 
          page: InkWellWithContainerPlayground()
        )
      ],
    );
  }
}

class InkWellWithContainerPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print('tapped'),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          ),
          child: Text('Hello'),
        ),
      ),
    );
  }

}

class FormPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlaygroundRow(
          child: DropdownMenu(
            dropdownMenuEntries: [
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
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
              DropdownMenuEntry(
                label: 'AED',
                value: 'AED'
              ),
            ]
          )
        ),
        PlaygroundRow(
          child: DropdownButton(
            value: 'USD',
            items: [
              DropdownMenuItem(
                value: 'USD',
                child: Text('USD')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'AED',
                child: Text('AED')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text('EUR')
              ),
            ],
            onChanged: (_) {}),
        )
      ],
    );
  }
}

class PlaygroundRow extends StatelessWidget {
  final Widget child;

  const PlaygroundRow({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Text Field',
                border: InputBorder.none,
              ),
            ),
          ),
          child
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
    return Text(
      value, 
      style: Theme.of(context).textTheme.titleMedium,
      //textAlign: TextAlign.center
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
      headBuilder: (BuildContext context, Function() onTap, bool opened) {
        return ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) => InkWell(
            onTap: onTap,
            child: headBuilder(value, opened),
          )
        );
      },
      bodyBuilder: (BuildContext context, Function() onItemTap) => Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: kElevationToShadow[3],
          ),
          child: Column(
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
        ),
      ),
    );
  }
}