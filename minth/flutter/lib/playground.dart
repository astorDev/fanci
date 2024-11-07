import 'package:fanci/widgets.dart';
import 'package:flutter/material.dart';
import 'package:minth/dropdown.dart';
import 'package:minth/theme.dart';

void main() {
  runApp(MinthPlaygroundApp());
}

class MinthPlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lt = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        dynamicSchemeVariant: DynamicSchemeVariant.monochrome
      )
    );


    return PlaygroundApp(
      appName: 'Minth', 
      theme: lt.copyWithMinthAdjustments(),
      darkTheme: ThemeData.dark().copyWithMinthAdjustments(),
      tabs: [
        PlaygroundTab(
          emoji: '🎨',
          label: 'Dropdown',
          page: SafeArea(
            child: Center(
              child: SizedBox(
                width: 120,
                child: ThemedDropdownMenu(
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
              )
            ),
          )
        )
      ]
    );
  }
}