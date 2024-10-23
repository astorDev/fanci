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
          emoji: '⚪',
          label: 'Basic',
          page: BasicPlayground(),
        ),
        PlaygroundTab(
          emoji: '🎨',
          label: 'Styled',
          page: StyledPlayground(),
        ),
        PlaygroundTab(
          emoji: '🔬',
          label: 'Advanced',
          page: AdvancedPlayground(),
        ),
      ],
    );
  }
}

class BasicPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownMenu(
          initialSelection: currencies[0],
          dropdownMenuEntries: [
            for (var currency in currencies)
              DropdownMenuEntry(
                label: currency.code,
                value: currency
              )
          ]
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
          dropdownMenuEntries: [
            for (var currency in currencies)
              DropdownMenuEntry(
                label: currency.code,
                value: currency
              )
          ],
          menuHeight: 200,
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 20,
          ),
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_up_sharp,
            size: 20
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.03),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                width: 0.6
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(1),
                width: 0.6
              ),
            )
          )
        ),
      ],
    );
  }
}

class AdvancedPlayground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: DropdownMenu(
            initialSelection: currencies[0],
            menuHeight: 200,
            dropdownMenuEntries: [
              for (var currency in currencies)
                DropdownMenuEntry(
                  label: currency.code,
                  labelWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currency.code),
                      Text(
                        currency.name, 
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])
                      )
                    ],
                  ),
                  value: currency
                )
            ],
            searchCallback: (List<DropdownMenuEntry<Currency?>> entries, String query) {
              return entries.indexWhere((e) => e.value!.contains(query));
            },
            trailingIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up_sharp,
              size: 20
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.03),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  width: 0.6
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(1),
                  width: 0.6
                ),
              )
            )
          ),
        )
      ],
    );
  }
}

class Currency {
  final String code;
  final String name;

  Currency({
    required this.code,
    required this.name
  });

  bool contains(String search) {
    return code.toLowerCase().contains(search.toLowerCase()) 
      || name.toLowerCase().contains(search.toLowerCase());
  }
}

List<Currency> currencies = [
  Currency(code: 'USD', name: 'United States Dollar'),
  Currency(code: 'EUR', name: 'Euro'),
  Currency(code: 'AED', name: 'United Arab Emirates Dirham'),
  Currency(code: 'BTC', name: 'Bitcoin'),
  Currency(code: 'SOL', name: 'Solana'),
];