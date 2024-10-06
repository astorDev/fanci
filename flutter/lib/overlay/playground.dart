import 'package:fanci/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(OverlayPlaygroundApp());
}

class OverlayPlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Overlay', 
      tabs: [
        PlaygroundTab(
          emoji: '🔵',
          label: 'Raw',
          page: RawOverlayPlayground()
        ),
        PlaygroundTab(
          emoji: '🔴',
          label: 'Following',
          page: FollowingOverlayPlayground()
        ),
      ]
    );
  }
}

class RawOverlayPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ShowBrickButton(
            adjustBrick: (brick) => brick,
            adjustmentLabel: 'Unadjusted'
          ),
          SizedBox(height: 20),
          ShowBrickButton(
            adjustBrick: (brick) => Positioned(height: 150, width: 150, child: brick),
            adjustmentLabel: 'Positioned'
          ),
          SizedBox(height: 20),
          ShowBrickButton(
            adjustBrick: (brick) => Align(child: brick),
            adjustmentLabel: 'Aligned'
          ),
        ],
      ),
    );
  }
}

class ShowBrickButton extends StatelessWidget {
  final Widget Function(Widget brick) adjustBrick;
  final String adjustmentLabel;

  const ShowBrickButton({
    required this.adjustBrick,
    required this.adjustmentLabel
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var entry = OverlayEntry(builder: (context) => adjustBrick(Brick()));

        Overlay.of(context).insert(entry);
        await Future.delayed(Duration(seconds: 1));
        entry.remove();
      },
      child: Text('Show $adjustmentLabel Brick'),
    );
  }
}

class FollowingOverlayPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowFollowerButton(
          adjustmentLabel: 'Unadjusted',
          adjustFollower: (follower) => follower
        ),
        SizedBox(height: 20),
        ShowFollowerButton(
          adjustmentLabel: 'Positioned',
          adjustFollower: (follower) => Positioned(height: 100, width: 100, child: follower)
        ),
        SizedBox(height: 20),
        ShowFollowerButton(
          adjustmentLabel: 'Aligned',
          adjustFollower: (follower) => Align(child: follower)
        ),
      ],
    );
  }
}

class ShowFollowerButton extends StatelessWidget {
  final LayerLink layerLink = LayerLink();
  final Widget Function(CompositedTransformFollower follower) adjustFollower;
  final String adjustmentLabel;

  ShowFollowerButton({
    required this.adjustmentLabel,
    required this.adjustFollower
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: ElevatedButton(
        onPressed: () async {
          var follower = CompositedTransformFollower(
            link: layerLink,
            targetAnchor: Alignment.bottomLeft,
            child: Brick()
          );

          var entry = OverlayEntry(builder: (context) => adjustFollower(follower));

          Overlay.of(context).insert(entry);
          Future.delayed(Duration(seconds: 1), () => entry.remove());
        }, 
        child: Text('Show $adjustmentLabel Follower'),
      )
    );
  }
}

class Brick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        boxShadow: kElevationToShadow[2]
      ),
    );
  }
}