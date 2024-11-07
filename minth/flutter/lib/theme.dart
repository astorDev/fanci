import 'package:flutter/material.dart';
import 'package:minth/dropdown.dart';

extension ThemeDataMinth on ThemeData {
  ThemeData copyWithMinthAdjustments() {
    return copyWith(
      extensions: [
        DropdownIconsTheme(
          trailingIcon: Icon(Icons.keyboard_arrow_down_sharp),
          selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_sharp),
        )
      ],
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.onSurface,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          maximumSize: WidgetStatePropertyAll(Size.fromHeight(120))
        ),
        inputDecorationTheme: InputDecorationTheme(
          
          filled: true,
          fillColor: colorScheme.onSurface.withOpacity(0.03),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withOpacity(0.1),
              width: 0.3
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withOpacity(0.2),
              width: 0.6
            ),
          )
        )
      )
    );
  }
}