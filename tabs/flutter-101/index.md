# Flutter Tabs: TabBar and TabBarView.

Tabs are a powerful layout tool frequently handy for a Flutter app. Interestingly enough, Flutter provides a rather unusual way of implementing them. In this article, I'll show you how to create a tab view. Starting from the basic implementation we'll investigate a few limitations and peculiarities Flutter tabs have and will try to overcome them. Let's jump to the code!

## Recap

In this article, we've investigated how to create a simple tabs layout in Flutter. Although it was quite simple it has an unpleasant requirement of hard-coding tab content height. Besides that, it provided a rather strange implementation, where the controller was acting like a widget. Ironically this peculiarity made overcoming the impediment of the built-in widget pretty easy.  We've implemented our own widget for displaying tab content, called `TabContentView` (which to my taste is a much clearer name, than `TabBarView`)

I've made `TabContentView` available in [package, called `fanci`](https://pub.dev/packages/fanci). You can add it to your project by using `flutter pub add fanci`. The source code for the tutorial and the package are also available on [Github](https://github.com/astorDev/fanci/tree/main/flutter/lib/tabs). 

And finally... claps are appreciated 👏
