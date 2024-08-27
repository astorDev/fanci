import 'package:fanci/fanci_playground.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FanciPlaygroundApp(
    appName: 'Fanci',
    tabs: [
      FanciPlaygroundTab(
        emoji: '🍎', 
        label: 'Apple',
        page: Center(child: Text('Page for Apple'))
      ),
      FanciPlaygroundTab(
        emoji: '🍌', 
        label: 'Banana',
        page: Center(child: Text('Rage for Banana'))
      ),
      FanciPlaygroundTab(
        emoji: '🍊', 
        label: 'Orange',
        page: Center(child: Text('Cage for Orange'))
      ),
    ],
  ));
}