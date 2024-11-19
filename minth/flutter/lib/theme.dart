import 'package:fanci_dropdown/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ThemeDataMinth on ThemeData {
  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: colorScheme.onSurface.withOpacity(0.2),
        width: 0.3
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: colorScheme.onSurface.withOpacity(0.3),
        width: 0.6
      ),
    ),
    hintStyle: TextStyle(
      color: colorScheme.onSurface.withOpacity(0.3),
    )
  );

  ThemeData copyWithMinthAdjustments() {
    var inputDecorationTheme = _inputDecorationTheme;

    return copyWith(
      extensions: [
        DropdownIconsTheme(
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 20,
          ),
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_up_sharp,
            size: 20,
          ),
        )
      ],
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.onSurface,
      ),
      inputDecorationTheme: inputDecorationTheme,
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          maximumSize: WidgetStatePropertyAll(Size.fromHeight(120))
        ),
        inputDecorationTheme: inputDecorationTheme.copyWith(
          filled: true,
          fillColor: colorScheme.onSurface.withOpacity(0.03),
        )
      )
    );
  }
}

extension ThemeDataLightMinth on ThemeData {
  ThemeData copyWithWhiteColoring() {
    return copyWith(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: Colors.black,
        primary: Colors.orange,
        onPrimary: Colors.green,
        secondary: Colors.purple,
        onSecondary: Colors.blue,
        error: Colors.pink,
        onError: Colors.yellow,
        surfaceBright: Colors.yellow,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      )
    );
  }
}