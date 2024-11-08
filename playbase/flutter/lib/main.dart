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
      appName: 'Playground', 
      tabs: [
        PlaygroundTab(
          emoji: '🏠',
          title: 'Home',
          child: Text('Home Page'), 
        ),
        PlaygroundTab(
          emoji: '🛣️',
          title: 'Street',
          child: Text('Street Page'), 
        ),
      ]
    );
  }
}