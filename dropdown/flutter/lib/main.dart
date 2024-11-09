import 'package:fanci_dropdown/dropdown.dart';
import 'package:fanci_playground/playground.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Dropdown',
      theme: ThemeData(
        extensions: [
          DropdownIconsTheme(
            trailingIcon: Icon(
              Icons.keyboard_arrow_down,
              size: 18,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up,
              size: 18,
            ),
          )
        ]
      ),
      tabs: [
        PlaygroundTab(
          emoji: '🏠', 
          title: 'Home', 
          child: HomeCase()
        ),
        PlaygroundTab(
          title: 'Simple',
          emoji: '🔢',
          child: Dropdown(
            initialSelection: 'item1',
            dropdownMenuEntries: [
              DropdownMenuEntry(label: 'Item 1', value: 'item1'),
              DropdownMenuEntry(label: 'Item 2', value: 'item2'),
              DropdownMenuEntry(label: 'Item 3', value: 'item3'),
            ],
          )
        )
      ]
    );
  }
}

class HomeCase extends StatelessWidget {
  final DropdownTextController controller = DropdownTextController(
    text: 'Item 1'
  );

  HomeCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: controller, 
          builder: (context, value, child) {
            return Text('Controller text value: $value');
          }
        ),
        SizedBox(height: 20),
        Dropdown(
          controller: controller,
          initialSelection: 'item1',
          dropdownMenuEntries: [
            DropdownMenuEntry(label: 'Item 1', value: 'item1'),
            DropdownMenuEntry(label: 'Item 2', value: 'item2'),
            DropdownMenuEntry(label: 'Item 3', value: 'item3'),
          ],
        )
      ],
    );
  }
}