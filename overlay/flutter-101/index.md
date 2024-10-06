# Flutter Overlay: Getting Started + CompositedTransformFollower

`Overlay` is a pretty fundamental Flutter widgets, used internally in many other popular widgets like `DropdownMenu`. Yet there's very little information about it in the internet. This article will show you how to use the widget, plus provide you insights on how to make the widget even more useful with widgets that get, undeservedly, even less attention: `CompositedTransformFollower` and `CompositedTransformTarget`. Let's jump to the code!

![](thumb.png)

## Showing the Brick

```dart
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
```

```dart
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
```

```dart
ShowBrickButton(
    adjustBrick: (brick) => brick,
    adjustmentLabel: 'Unadjusted'
),
```

![](brick-unadjusted.gif)

## Giving Constraints

```dart
ShowBrickButton(
    adjustBrick: (brick) => Positioned(height: 150, width: 150, child: brick),
    adjustmentLabel: 'Positioned'
),
```

![](brick-positioned.gif)

```dart
ShowBrickButton(
    adjustBrick: (brick) => Align(child: brick),
    adjustmentLabel: 'Aligned'
),
```

![](brick-aligned.gif)

## Following Widgets

```dart
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
```

```dart
ShowFollowerButton(
  adjustmentLabel: 'Unadjusted',
  adjustFollower: (follower) => follower
),
```

![](follower-unadjusted.gif)

## Adjusting the Follower

```dart
ShowFollowerButton(
  adjustmentLabel: 'Positioned',
  adjustFollower: (follower) => Positioned(height: 100, width: 100, child: follower)
),
```

![](follower-positioned.gif)

```dart
ShowFollowerButton(
  adjustmentLabel: 'Aligned',
  adjustFollower: (follower) => Align(child: follower)
),
```

![](follower-aligned.gif)

## Wrapping Up!

I hope that article brings `Overlay` to your arsenal to build some exciting UIs in Flutter. Combination of `CompositedTransformTarget`, `CompositedTransformFollower`, and `Align` should be enough to build a real-life application widgets, such as dropdowns or hints. And if this article was helpful .. I would appreciate some claps! 😉

You can play around with the code from this article, cloning [this repository](https://github.com/astorDev/fanci). And here's a gif, showing everything we've built through out this article:

![](overview.gif)

