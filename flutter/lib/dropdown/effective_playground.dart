import 'package:fanci/dropdown/widgets.dart';
import 'package:flutter/material.dart';

class EffectivePlayground extends StatefulWidget {
  @override
  State<EffectivePlayground> createState() => _EffectivePlaygroundState();
}

class _EffectivePlaygroundState extends State<EffectivePlayground> {
  ValueNotifier<String> selectedController = ValueNotifier('USD');
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FocusListeningUnderline(
      focusNode: focusNode,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Text',
                border: InputBorder.none,
              ),
            ),
          ),
          DefaultDropdownSelector(
            selectedController: selectedController, 
            options: [ 'USD', 'EUR', 'AED', 'BTC', 'ETH', 'XRP', 'XNO' ]
          ),
          DefaultDropdownSelector(
            selectedController: selectedController, 
            options: [ 'USD', 'EUR' ]
          )
        ]
      )
    );
  } 
}