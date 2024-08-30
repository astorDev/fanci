# Flutter Animations: Getting Started

> A tutorial on how to build a simple, yet functional animation in Flutter

I've always found it fascinating how ridiculously complex Flutter tutorials make animating a bouncing ball. Or making some other useless for a real app animation. I'll try to make this article different. We are going to build a sliding selected tab indicator, like the one you can find in a `TabBar` widget. The animation will only require one widget and one controller. Let's get started!

> You can check exactly what we are going to do in the [TLDR;](#tldr)

![](thumb.png)

##

Let sum this up!

## TLDR;

Using `AnimationController` we was able to trigger animation by calling `animationController.forward(from: 0);` when a user taps on `Slide Under Random Icon`. Then on each `AnimatedBuilder` build we calculate `currentPosition` based on the current progress indicated by the `animation.value`, starting indicator position, stored as  `tabSelection.previous` and target indicator position, stored as `tabSelection.current`. And this is what it looks like:

> Keep in mind that this below is a gif, and the animation is much smoother in the real life

![](final-demo.gif)

By the way... Claps are appreciated! 👏