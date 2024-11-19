import 'package:flutter/material.dart';

class CompositeField extends StatelessWidget {
  final Widget leading;
  final Widget main;
  final ValueNotifier<bool> focusNotifier = ValueNotifier(false);

  CompositeField({ 
    required this.leading,
    required this.main
  });

  BoxDecoration maybeApplyInputDecoration(BuildContext context, BoxDecoration decoration, bool focused) {
    var inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    var inputBorder = focused ? inputDecorationTheme.focusedBorder : inputDecorationTheme.enabledBorder;

    if (inputBorder is OutlineInputBorder) {
      return decoration.copyWith(
        border: Border.fromBorderSide(inputBorder.borderSide),
        borderRadius: inputBorder.borderRadius
      );  
    }

    return decoration;
  }
  
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (x) {
        focusNotifier.value = x;
      },
      child: ValueListenableBuilder(
        valueListenable: focusNotifier,
        builder: (context, focused, child) {
          return Container(
            decoration: maybeApplyInputDecoration(context, BoxDecoration(), focused),
            child: child,
          );
        },
        child: Row(
          children: [
            leading,
            SizedBox(width: 16),
            Expanded(
              child: main
            )
          ],
        ),
      ),
    );
  }
}