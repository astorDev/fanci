# Flutter Tabs: TabBar and TabBarView.

Tabs are a powerful layout tool, frequently coming handy for a Flutter up. Interestingly enough, Flutter provides a rather unusual way of implementing them. In this article, I'll walk you through creating a tabs view. Starting from the basic implementation we'll investigate a few limitation and peculiarities Flutter tabs have and will try to overcome them. Let's jump to the code!

## Recap

In this article, we've investigated how to create a simple tabs layout in Flutter. Although it was quite simple it has some unpleasant requirement. Besides that, it provided a rather strange implementation, where controller was acting like a widget. Ironically this peculiarity made overcoming the impediment of the built-in widget pretty easy.  We've implemented our own widget for displaying tab content, called `TabContentView` (which to my taste is much clearer name, then `TabBarView`)

I've made `TabContentView` avaiable in [package, called `fanci`](https://pub.dev/packages/fanci). You can add it to your project by using `flutter pub add fanci`. Source code for the tutorial and the package is also available on [Github](https://github.com/astorDev/fanci/tree/main/flutter/lib/tabs). 

And finally... claps are appreciated 👏