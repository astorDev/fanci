import 'package:fanci/fanci_playground.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LifecyclePlaygroundApp());
}

class LifecyclePlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Lifecycle', 
      tabs: const [
        PlaygroundTab(
          emoji: '🚀',
          label: 'Main',
          page: LifecycleMainCase()
        ),
      ]
    );
  }
}

class LifecycleMainCase extends StatefulWidget {
  const LifecycleMainCase({super.key});

  @override
  State<LifecycleMainCase> createState() => _LifecycleMainCaseState();
}

class _LifecycleMainCaseState extends State<LifecycleMainCase> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Main'),
        PlaygroundContainer(name: 'Green (Not const prefixed)', color: Colors.green),
        const PlaygroundContainer(name: 'Red (const prefixed)', color: Colors.red),
        const PlaygroundContainer(
          name: 'Blue (const prefixed with child)', 
          color: Colors.blue,
          child: Text('Child')
        ),
        const PseudoStatefulPlaygroundController(
          name: 'Purple (pseudo stateful)', 
          color: Colors.purple
        ),
        TextButton(
          onPressed: () => setState(() { counter++; }), 
          child: const Text('setState')
        )
      ],
    );
  }
}

class PlaygroundContainer extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final Widget? child;
  final Color color;

  const PlaygroundContainer({
    required this.name,
    this.width = 100,
    this.height = 100,
    this.child,
    this.color = Colors.blue,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    print('building $name');

    return Container(
      width: width,
      height: height,
      color: color,
      child: child,
    );
  }
}

class PseudoStatefulPlaygroundController extends StatefulWidget {
  final String name;
  final double width;
  final double height;
  final Widget? child;
  final Color color;

  const PseudoStatefulPlaygroundController({
    required this.name,
    this.width = 100,
    this.height = 100,
    this.child,
    this.color = Colors.blue,
    super.key
  });

  @override
  State<PseudoStatefulPlaygroundController> createState() => _PseudoStatefulPlaygroundControllerState();
}

class _PseudoStatefulPlaygroundControllerState extends State<PseudoStatefulPlaygroundController> {


  @override
  Widget build(BuildContext context) {
    print('building ${widget.name}');

    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.color,
      child: widget.child,
    );
  }
}