import 'package:flutter/material.dart';

class FanciPlaygroundApp extends StatelessWidget {
  final ThemeModeController themeModeController = ThemeModeController(ThemeMode.light);
  final String appName;
  final List<FanciPlaygroundTab> tabs;

  FanciPlaygroundApp({
    required this.appName,
    required this.tabs,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ThemedBuilder(
      builder: (themeController) => MaterialApp(
        title: '$appName Playground',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.value,
        home: FanciPlaygroundPage(
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

class FanciPlaygroundPage extends StatefulWidget {
  final String appName;
  final List<FanciPlaygroundTab> tabs;
  final ThemeModeController? themeModeController;

  const FanciPlaygroundPage({
    super.key,
    required this.appName,
    required this.tabs,
    this.themeModeController
  });

  @override
  State<FanciPlaygroundPage> createState() => _FanciPlaygroundPageState();
}

class _FanciPlaygroundPageState extends State<FanciPlaygroundPage> {
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
              return widget.tabs[pageIndex].page;
            }
          ),
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

class ThemeModeController extends ValueNotifier<ThemeMode> {
  ThemeModeController(super.value);

  void toggle() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}