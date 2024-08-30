# Flutter Animations: Getting Started

> A tutorial on how to build a simple, yet functional animation in Flutter

I've always found it fascinating how ridiculously complex Flutter tutorials make animating a bouncing ball... or making some other useless for a real app animation. I'll try to make this article different. We will build a sliding tab indicator, like the one you can find in a `TabBar` widget. The animation will only require one widget and one controller. Without further ado, let's get started!

> You can check exactly what we are going to do in the [TLDR;](#tldr)

![](thumb.png)

##

Let's sum this up!

## TLDR;

Using `AnimationController` we were able to trigger animation by calling `animationController.forward(from: 0);` when a user taps on `Slide Under Random Icon`. Then on each `AnimatedBuilder` build we calculate `currentPosition` based on the current progress indicated by the `animation.value`, starting indicator position, stored as  `tabSelection.previous` and target indicator position, stored as `tabSelection.current`. And this is what it looks like:

> Keep in mind that this below is a gif, and the animation is much smoother in the real-life

![](final-demo.gif)

You can check out the full code [here](https://github.com/astorDev/fanci/blob/main/flutter/lib/animation/stack_based_case.dart). There's also a playground app in the repo. And one more thing... Claps are appreciated! 👏
