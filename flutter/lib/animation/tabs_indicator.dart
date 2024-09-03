import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabsIndicatorCaseVersioned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('V1'),
      TabsIndicatorCaseV1(),
      SizedBox(height: 30),
      Text('V2'),
      TabsIndicatorCaseV2(),
      SizedBox(height: 30),
      Text('V3'),
      TabsIndicatorCaseV3(),
      SizedBox(height: 30),
      Text('Tabs And Animation Controllers'),
      TabsIndicatorCaseFinal(),
      SizedBox(height: 30),
      Text('AnimatedPadding Based'),
      TabsIndicatorCaseAnimatedOffset(),
      SizedBox(height: 30),
      Text('Thumbnail'),
      TabsIndicatorCaseThumbnail()
    ]);
  }
}

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 3,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
    );
  }
}

class ShowcaseStackCard extends StatelessWidget {
  final Widget child;
  final Function()? onButtonPressed;

  const ShowcaseStackCard({
    super.key,
    this.onButtonPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 80,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: onButtonPressed,
                    child: Text('Slide Under Random Icon')),
                const Row(
                  children: [
                    Expanded(child: Icon(Icons.square)),
                    Expanded(child: Icon(Icons.circle)),
                    Expanded(child: Icon(Icons.star)),
                  ],
                )
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class TabsIndicatorCaseV1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowcaseStackCard(
      child: Indicator(),
    );
  }
}

class RelativelyPositioned extends StatelessWidget {
  final Widget child;
  final Offset Function(Size size) positionCalculator;

  const RelativelyPositioned({
    super.key,
    required this.child,
    required this.positionCalculator,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrained) {
      var position = positionCalculator(constrained.biggest);
      return Padding(
        padding: EdgeInsets.only(top: position.dy, left: position.dx),
        child: child,
      );
    });
  }
}

double calculateLeftOffset(int targetIndex, double totalWidth) {
  var totalElementsCount = 3;
  var indicatorWidth = 30;

  var spaceWidth = (totalWidth - indicatorWidth * totalElementsCount) / (totalElementsCount * 2);
  var usedBySpaces = (1 + (targetIndex * 2)) * spaceWidth;
  var usedByIndicators = targetIndex * indicatorWidth;
  return usedBySpaces + usedByIndicators;
}

class TabsIndicatorCaseV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowcaseStackCard(
      child: RelativelyPositioned(
        positionCalculator: (size) => Offset(
          calculateLeftOffset(2, size.width), 
          size.height - 3
        ),
        child: Indicator()
      ),
    );
  }
}

double calculateMovingLeftOffset({
  required int sourceIndex,
  required int targetIndex,
  required double progress,
  required double totalWidth
}) {
  var targetPosition = calculateLeftOffset(targetIndex, totalWidth);
  var sourcePosition = calculateLeftOffset(sourceIndex, totalWidth);

  var distance = (targetPosition - sourcePosition).abs();
  var passedDistance = distance * progress;

  return targetPosition > sourcePosition
      ? sourcePosition + passedDistance
      : sourcePosition - passedDistance;
}

class IndexSelection {
  final int current;
  final int? previous;

  IndexSelection(this.current, this.previous);
}

class IndexSelectionController extends ChangeNotifier implements ValueListenable<IndexSelection> {
  IndexSelection _value = IndexSelection(0, null);
  @override
  IndexSelection get value => _value;

  void select(int tabIndex) {
    _value = IndexSelection(tabIndex, _value.current);
    notifyListeners();
  }

  void switchRandom(int total) {
    var random = Random();
    var target = random.nextInt(total);
    while (target == _value.current) {
      target = random.nextInt(total);
    }

    select(target);
  }
}

class TabsIndicatorCaseV3 extends StatelessWidget {
  final IndexSelectionController indexController = IndexSelectionController();

  @override
  Widget build(BuildContext context) {
    return ShowcaseStackCard(
      child: ValueListenableBuilder(
        valueListenable: indexController,
        builder: (context, v, child) {
          return RelativelyPositioned(
            positionCalculator: (size) => Offset(
              calculateMovingLeftOffset(
                sourceIndex: v.previous ?? 0, 
                targetIndex: v.current,
                progress: 1,
                totalWidth: size.width), 
              size.height - 3
            ),
            child: Indicator());
        }
      ),
      onButtonPressed: () => indexController.switchRandom(3)
    );
  }
}

class TabsIndicatorCaseFinal extends StatefulWidget {
  @override
  State<TabsIndicatorCaseFinal> createState() => _TabsIndicatorCaseFinalState();
}

class _TabsIndicatorCaseFinalState extends State<TabsIndicatorCaseFinal> with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  final IndexSelectionController indexController = IndexSelectionController();

  @override
  void initState() {
    super.initState();

    indexController.addListener(() {
      animationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseStackCard(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return RelativelyPositioned(
            positionCalculator: (size) => Offset(
              calculateMovingLeftOffset(
                sourceIndex: indexController.value.previous ?? 0,
                targetIndex: indexController.value.current,
                progress: animationController.value,
                totalWidth: size.width
              ),
              size.height - 3
            ),
            child: Indicator(), 
          );
        }),
      onButtonPressed: () => indexController.switchRandom(3)
    );
  }
}

class TabsIndicatorCaseAnimatedOffset extends StatefulWidget {
  const TabsIndicatorCaseAnimatedOffset({super.key});

  @override
  State<TabsIndicatorCaseAnimatedOffset> createState() => _TabsIndicatorCaseAnimatedOffsetState();
}

class _TabsIndicatorCaseAnimatedOffsetState extends State<TabsIndicatorCaseAnimatedOffset> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ShowcaseStackCard(
      child: LayoutBuilder(
        builder: (ctx, constrains) {
          var size = constrains.biggest;

          return AnimatedPadding(
            padding: EdgeInsets.only(
              left: calculateLeftOffset(selectedIndex, size.width),
              top: size.height - 3
            ),
            duration: const Duration(milliseconds: 200),
            child: Indicator(),
          );
        }
      ),
      onButtonPressed: () => setState(() {
        var target = Random().nextInt(3);
        while (target == selectedIndex) {
          target = Random().nextInt(3);
        }

        selectedIndex = target;
      })
    );
  
  }
}


class ThumbnailStackCard extends StatelessWidget {
  final List<Widget> children;
  final Function()? onButtonPressed;

  const ThumbnailStackCard({
    super.key,
    this.onButtonPressed,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 80,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: onButtonPressed,
                    child: Text('Slide Under Random Icon')),
                Row(
                  children: const [
                    Expanded(child: Icon(Icons.square)),
                    Expanded(child: Icon(Icons.circle)),
                    Expanded(child: Icon(Icons.star)),
                  ],
                )
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

Widget flowImitatingIndicator(double progress, double opacity) {
  return Opacity(
    opacity: opacity,
    child: RelativelyPositioned(
      positionCalculator: (size) => Offset(
        calculateMovingLeftOffset(
          sourceIndex: 1,
          targetIndex: 2,
          progress: progress,
          totalWidth: size.width
        ),
        size.height - 3
      ),
      child: Indicator(), 
    ),
  );
}

class TabsIndicatorCaseThumbnail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThumbnailStackCard(
      onButtonPressed: () {},
      children: [
        flowImitatingIndicator(0.6, 0.05),
        flowImitatingIndicator(0.65, 0.1),
        flowImitatingIndicator(0.7, 0.15),
        flowImitatingIndicator(0.75, 0.2),
        flowImitatingIndicator(0.8, 0.25),
        flowImitatingIndicator(0.85, 0.3),
        flowImitatingIndicator(0.9, 0.35),
        flowImitatingIndicator(1, 1),
      ],
    );
  }  
}