import 'package:flutter/material.dart';

class PlaygroundApp extends StatelessWidget {
  final ThemeModeController themeModeController = ThemeModeController(ThemeMode.light);
  final String appName;
  final List<PlaygroundTab> tabs;
  final ThemeData? theme;
  final ThemeData? darkTheme;

  PlaygroundApp({
    required this.appName,
    required this.tabs,
    this.theme,
    this.darkTheme,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ThemedBuilder(
      builder: (themeController) => MaterialApp(
        title: '$appName Playground',
        debugShowCheckedModeBanner: false,
        theme: theme ?? ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: darkTheme ?? ThemeData.dark(),
        themeMode: themeController.value,
        home: PlaygroundPage(
          appName: appName,
          tabs: tabs,
          themeModeController: themeController,
        ),
      ),
    );
  }
}

class ThemedBuilder extends StatelessWidget {
  final ThemeModeController themeModeController = ThemeModeController(ThemeMode.light);
  final Widget Function(ThemeModeController) builder;

  ThemedBuilder({
    required this.builder,
    super.key
  });
  
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: themeModeController, 
    builder: (context, _, __) => builder(themeModeController)
  );
}

class PlaygroundPage extends StatefulWidget {
  final String appName;
  final List<PlaygroundTab> tabs;
  final ThemeModeController? themeModeController;

  const PlaygroundPage({
    super.key,
    required this.appName,
    required this.tabs,
    this.themeModeController
  });

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  final ValueNotifier navigationBarIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appName} Playground'),
        actions: [
          if (widget.themeModeController != null) IconButton(
            icon: const Icon(Icons.brightness_4_sharp),
            onPressed: () => widget.themeModeController!.toggle(),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: navigationBarIndex,
        builder: (context, pageIndex, _) {
          if (widget.tabs.length == 1) return Container(height: 0);
          
          return NavigationBar(
            selectedIndex: pageIndex,
            onDestinationSelected: (index) => navigationBarIndex.value = index,
            destinations: widget.tabs.map((t) => t.navigationDestination).toList()
          );
        } ,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: ValueListenableBuilder(
            valueListenable: navigationBarIndex,
            builder: (context, pageIndex, _) {
              return widget.tabs[pageIndex].child;
            }
          ),
        ),
      ),
    );
  }
}

class PlaygroundTab {
  final String emoji;
  final String title;
  final Widget child;

  NavigationDestination get navigationDestination => NavigationDestination(
    icon: Text(emoji),
    label: title,
  );

  const PlaygroundTab({
    required this.emoji, 
    required this.title, 
    required this.child
  });
}

class ThemeModeController extends ValueNotifier<ThemeMode> {
  ThemeModeController(super.value);

  void toggle() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}