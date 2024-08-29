import 'dart:math';
import 'package:fanci/animation/playground.dart';
import 'package:fanci/main.dart';
import 'package:flutter/material.dart';

class StackBasedCase extends StatefulWidget {
  @override
  State<StackBasedCase> createState() => _StackBasedCaseState();
}

class _StackBasedCaseState extends State<StackBasedCase> with SingleTickerProviderStateMixin  {
  int divider = 100;
  Random random = Random();

  final TabSelectionController tabSelectionController = TabSelectionController();
  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    tabSelectionController.addListener(() {
      animationController.forward(from: 0);
    });
  }

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
                  onPressed: () {
                    switchToRandomTab(tabSelectionController);
                  },
                  child: Text('Slide Under Random Icon')
                ),
                ExpandedIconRow(),
              ],
            ),
            ...flowImitationIndicatorWidgets()

            // AnimatedBuilder(
            //   animation: animationController, 
            //   builder: (_, __) {
            //     return LayoutedMarginedIndicator(
            //       tabSelection: tabSelectionController.value,
            //       progress: animationController.value,
            //     );
            //   }
            // )

          ],
        ),
      ),
    );
  }
}

List<Widget> flowImitationIndicatorWidgets() {
  
  
  return [
    LayoutedMarginedIndicator(
      tabSelection: TabSelection(2, 1),
      progress: 0.3,
      opacity: 0.1,
    ),
    LayoutedMarginedIndicator(
      tabSelection: TabSelection(2, 1),
      progress: 0.4,
      opacity: 0.15,
    ),
    LayoutedMarginedIndicator(
      tabSelection: TabSelection(2, 1),
      progress: 0.6,
      opacity: 0.2,
    ),
    LayoutedMarginedIndicator(
      tabSelection: TabSelection(2, 1),
      progress: 0.8,
      opacity: 0.25,
    ),
    LayoutedMarginedIndicator(
      tabSelection: TabSelection(2, 1),
      progress: 0.9,
      opacity: 0.3,
    ),
    LayoutedMarginedIndicator(
      tabSelection: TabSelection(2, 1),
      progress: 1,
      opacity: 1,
    ),
  ];
}

class LayoutedMarginedIndicator extends StatelessWidget {
  final TabSelection tabSelection;
  final double progress;
  final double opacity;

  const LayoutedMarginedIndicator({
    super.key,
    required this.tabSelection,
    required this.progress,
    this.opacity = 1,
  });


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrained) {
        var currentPosition = calculateCurrentPosition(
          tabSelection.previous ?? 0, 
          tabSelection.current, 
          progress, 
          constrained.maxWidth,
          indicatorWidth: 30
        );
    
        return MarginedIndicator(
          top: constrained.maxHeight - 3,
          left: currentPosition,
          opacity: opacity,
        );
      }
    );
  }
}

class MarginedIndicator extends StatelessWidget {
  final double top;
  final double left;
  final double opacity;

  const MarginedIndicator({
    super.key,
    required this.top,
    required this.left,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: top,
        left: left
      ),
      width: 30,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(opacity),
        borderRadius: BorderRadius.vertical(top: Radius.circular(5))
      ),
    );
  }
}