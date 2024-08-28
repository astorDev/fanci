import 'package:fanci/mock_column.dart';
import 'package:flutter/material.dart';

class SlidingShowcase extends StatefulWidget {
  @override
  State<SlidingShowcase> createState() => _SlidingShowcaseState();
}

class _SlidingShowcaseState extends State<SlidingShowcase> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )
  ..forward()
  //..repeat(reverse: true)
  ;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 400,
        height: 200,
        child: Column(
          children: [
            StandardSlidingRight(
              animationController: controller,
              child: MockColumn(),
            ),
            TextButton(
              onPressed: () {
                controller.forward(from: 0);
              } , 
              child: Text('Slide')
            )
          ],
        )
      ),
    );
  }
}

enum SlideDirection {
  left,
  right,
}

class StandardSlidingRight extends StatefulWidget {
  final AnimationController animationController;
  final Widget child;

  const StandardSlidingRight({
    required this.animationController,
    required this.child,
    super.key,
  });

  @override
  State<StandardSlidingRight> createState() => _StandardSlidingRightState();
}

class _StandardSlidingRightState extends State<StandardSlidingRight> {
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-3.0, 0.0),
    end: const Offset(0.0, 0.0)
  ).animate(CurvedAnimation(
    parent: widget.animationController,
    curve: Curves.ease,
  ));

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}

class StandardSlidingLeft extends StatefulWidget {
  final AnimationController animationController;
  final Widget child;

  const StandardSlidingLeft({
    required this.animationController,
    required this.child,
    super.key,
  });

  @override
  State<StandardSlidingLeft> createState() => _StandardSlidingLeftState();
}

class _StandardSlidingLeftState extends State<StandardSlidingLeft> {
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(3.0, 0.0),
    end: const Offset(0.0, 0.0)
  ).animate(CurvedAnimation(
    parent: widget.animationController,
    curve: Curves.ease,
  ));

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}

class StandardSliding extends StatelessWidget {
  final SlideDirection direction;
  final AnimationController animationController;
  final Widget child;

  const StandardSliding({
    required this.direction,
    required this.animationController,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return direction == SlideDirection.left
      ? StandardSlidingLeft(animationController: animationController, child: child)
      : StandardSlidingRight(animationController: animationController, child: child);
  }
}