import 'dart:math';

import 'package:fanci/main.dart';
import 'package:fanci/mock_column.dart';
import 'package:flutter/material.dart';

class SlidingShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            width: 400,
            height: 200,
            child: StandardSlidingCase()
          ),
        ),
        SizedBox(height: 20),
        Card(
          child: SizedBox(
            width: 400,
            height: 200,
            child: SecondSlidingCase()
          ),
        ),
      ],
    );
  }
}

class StandardSlidingCase extends StatefulWidget {
  @override
  State<StandardSlidingCase> createState() => _StandardSlidingCaseState();
}

class _StandardSlidingCaseState extends State<StandardSlidingCase> with SingleTickerProviderStateMixin {
  late final AnimationController firstController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )
  ..forward()
  ;

  @override
  void dispose() {
    firstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandardSlidingRight(
          animationController: firstController,
          child: MockColumn(),
        ),
        TextButton(
          onPressed: () {
            firstController.forward(from: 0);
          } , 
          child: Text('Slide')
        )
      ],
    );
  }
}

class SecondSlidingCase extends StatefulWidget {
  @override
  State<SecondSlidingCase> createState() => _SecondSlidingCaseState();
}

class _SecondSlidingCaseState extends State<SecondSlidingCase> with SingleTickerProviderStateMixin {
  TabSelectionController currentIndexController = TabSelectionController();

  late final AnimationController firstController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )
  ..forward()
  ;

  late final Animation<double> animation = Tween<double>(
    begin: 0,
    end: 1
  ).animate(CurvedAnimation(
    parent: firstController,
    curve: Curves.ease,
  ));

  @override
  void dispose() {
    firstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(child: Icon(Icons.arrow_circle_right_rounded)),
            Expanded(child: Icon(Icons.circle)),
            Expanded(child: Icon(Icons.star)),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: currentIndexController,
          builder: (context, selection, child) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: IndicatorCustomPainter(
                    sourceIndex: selection.previous ?? 0,
                    targetIndex: selection.current,
                    progress: animation.value,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 20,
                  ),
                );
              }
            );
          }
        ),
        TextButton(
          onPressed: () {
            var random = Random();
            var target = random.nextInt(3);
            while (target == currentIndexController.value.current) {
              target = random.nextInt(3);
            }

            currentIndexController.select(target);
            firstController.forward(from: 0);
          } , 
          child: Text('Slide')
        )
      ],
    );
  }
}

class IndicatorCustomPainter extends CustomPainter {
  double indicatorWidth = 20;
  int targetIndex;
  int sourceIndex;
  double progress;

  IndicatorCustomPainter({
    this.targetIndex = 0,
    this.sourceIndex = 0,
    this.progress = 1,
  });

  double calculatePosition(int index, double totalWidth) {
  var widthExcludingIndicators = totalWidth - indicatorWidth * 3;
    var spaceSplitByIndicators = widthExcludingIndicators / 6;

    var usedByOffIndicators = index * indicatorWidth;
    var spacesCountBeforeCurrentIndicator = index * 2 + 1;
    var usedBySpaces = spacesCountBeforeCurrentIndicator * spaceSplitByIndicators; 

    return usedBySpaces + usedByOffIndicators;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var targetPosition = calculatePosition(targetIndex, size.width);
    var sourcePosition = calculatePosition(sourceIndex, size.width);
    var distance = (targetPosition - sourcePosition).abs();
    var passedDistance = distance * progress;
    var currentPosition = targetPosition > sourcePosition ? 
      sourcePosition + passedDistance
      : sourcePosition - passedDistance;

    canvas.drawRect(
      Rect.fromLTWH(
        currentPosition,
        0, 
        indicatorWidth,
        5
      ),
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill
    );
  }

  @override
  bool shouldRepaint(IndicatorCustomPainter oldDelegate) {
    return true;
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