import 'package:flutter/material.dart';

ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

class FanciPlaygroundApp extends StatelessWidget {
  final String appName;
  final List<FanciPlaygroundTab> tabs;

  const FanciPlaygroundApp({
    required this.appName,
    required this.tabs,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeMode,
      builder: (context, themeMode, _) => MaterialApp(
        title: '$appName Playground',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        home: FancyPlaygroundPage(
          appName: appName,
          tabs: tabs
        ),
      ),
    );
  }
}

class FancyPlaygroundPage extends StatelessWidget {
  final String appName;
  final ValueNotifier navigationBarIndex = ValueNotifier(0);
  final List<FanciPlaygroundTab> tabs;
  final ValueNotifier<ThemeMode>? themeModeController;

  FancyPlaygroundPage({
    super.key,
    required this.appName,
    required this.tabs,
    this.themeModeController
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$appName Playground'),
        actions: [
          if (themeModeController != null) IconButton(
            icon: const Icon(Icons.brightness_4_sharp),
            onPressed: () {
              themeModeController!.value = themeModeController!.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: navigationBarIndex,
        builder: (context, pageIndex, _) {
          if (tabs.length == 1) return Container(height: 0);
          
          return NavigationBar(
            selectedIndex: pageIndex,
            onDestinationSelected: (index) => navigationBarIndex.value = index,
            destinations: tabs.map((t) => t.navigationDestination).toList()
          );
        } ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ValueListenableBuilder(
          valueListenable: navigationBarIndex,
          builder: (context, pageIndex, _) {
            return tabs[pageIndex].page;
          }
        ),
      ),
    );
  }
}

class FanciPlaygroundTab {
  final String emoji;
  final String label;
  final Widget page;

  NavigationDestination get navigationDestination => NavigationDestination(
    icon: Text(emoji),
    label: label,
  );

  FanciPlaygroundTab({
    required this.emoji, 
    required this.label, 
    required this.page
  });
}