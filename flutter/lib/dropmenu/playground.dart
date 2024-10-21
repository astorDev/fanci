import 'package:fanci/fanci_playground.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DropdownPlaygroundApp());
}

class DropdownPlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaygroundApp(
      appName: 'Dropdown',
      tabs: [
        PlaygroundTab(
          emoji: '🎨',
          label: 'Styled',
          page: StyledPlayground(),
        ),
        PlaygroundTab(
          emoji: '⚪',
          label: 'Basic',
          page: BasicPlayground(),
        ),
      ],
    );
  }
}

class StyledPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownMenu(
          initialSelection: currencies[0],
          dropdownMenuEntries: currencies.map(toDropdownMenuEntry).toList(),
          inputDecorationTheme: InputDecorationTheme(),
        ),
      ],
    );
  }
}

class BasicPlayground extends StatefulWidget {
  @override
  State<BasicPlayground> createState() => _BasicPlaygroundState();
}

class _BasicPlaygroundState extends State<BasicPlayground> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownMenu(
          initialSelection: currencies[0],
          dropdownMenuEntries: currencies.map(toDropdownMenuEntry).toList(),
        ),
        SizedBox(height: 50),
        DropdownMenu(
          controller: _controller,
          initialSelection: currencies[0],
          dropdownMenuEntries: currencies.map(toDropdownMenuEntry).toList()
        ),
        ValueListenableBuilder(
          valueListenable: _controller, 
          builder: (context, value, child) {
            return Text('Picker: ${value.text}');
          }
        )
      ],
    );
  }
}

DropdownMenuEntry toDropdownMenuEntry(Currency currency) {
  return DropdownMenuEntry(
    label: currency.symbol,
    value: currency
  );
}

DropdownMenuEntry currency = DropdownMenuEntry(
  label: 'USD',
  value: Currency(symbol: 'USD')
);

class Currency {
  final String symbol;

  Currency({
    required this.symbol
  });
}

List<Currency> currencies = [
  Currency(symbol: 'USD'),
  Currency(symbol: 'EUR'),
  Currency(symbol: 'AED'),
  Currency(symbol: 'BTC'),
  Currency(symbol: 'SOL'),
  Currency(symbol: 'XNO'),
];