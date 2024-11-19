import 'package:fanci_dropdown/dropdown.dart';
import 'package:fanci_playground/playground.dart';
import 'package:flutter/material.dart';
import 'package:minth/chest.dart';
import 'package:minth/theme.dart';
import 'package:minth/widgets.dart';

void main() {
  runApp(MinthPlaygroundApp());
}

class MinthPlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Minth', 
      theme: ThemeData()
        .copyWithWhiteColoring()
        .copyWithMinthAdjustments(),
      darkTheme: ThemeData
        .dark()
        .copyWithMinthAdjustments(),
      tabs: [
        PlaygroundTab(
          emoji: '🔽',
          title: 'Dropdown',
          child: CompositeField(
            leading: SizedBox(
              width: 120,
              child: Dropdown(
                initialSelection: 'AED',
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'USD', label: 'USD (United States Dollar)'),
                  DropdownMenuEntry(value: 'AED', label: 'AED (United Arab Emirates Dirham)'),
                  DropdownMenuEntry(value: 'C', label: 'CCCCCCCCCC'),
                  DropdownMenuEntry(value: 'D', label: 'DDDDDDDDDD'),
                  DropdownMenuEntry(value: 'E', label: 'EEEEEEEEEE'),
                  DropdownMenuEntry(value: 'F', label: 'FFFFFFFFFF'),
                ],
              ),
            ),
            main: TextField(
              decoration: InputDecorations.transparent.copyWith(
                hintText: 'Amount',
              ),
            ),
          )
        )
      ]
    );
  }
}