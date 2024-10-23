# Flutter DropdownMenu In-Depth

Flutter 3.10 introduced a new dropdown widget: DropdownMenu. This widget is way more versatile than the previously used DropdownButton and Flutter docs recommend to use it over the old widget. Yet there's not much information available on the widget. In this article we'll play around with the widget, investigating its various aspects and functionalities. Let's jump to the code!

![](thumb.png)

## Preparing the Basics

```dart
class Currency {
  final String code;

  Currency({
    required this.code
  });
}

List<Currency> currencies = [
  Currency(code: 'USD'),
  Currency(code: 'EUR'),
  Currency(code: 'AED'),
  Currency(code: 'BTC'),
  Currency(code: 'SOL'),
];
```

```dart
DropdownMenu(
  initialSelection: currencies[0],
  dropdownMenuEntries: [
    for (var currency in currencies)
      DropdownMenuEntry(
        label: currency.code,
        value: currency
      )
  ]
)
```

![](basic.gif)

## Spicing the Looks

```dart
menuHeight: 200,
```

```dart
trailingIcon: Icon(
  Icons.keyboard_arrow_down_sharp,
  size: 20,
),
selectedTrailingIcon: Icon(
  Icons.keyboard_arrow_up_sharp,
  size: 20
),
```

```dart
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
```

![](styled.gif)

## Search on Steroids

```dart
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
```

```dart
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
```

```dart
bool contains(String search) {
  return code.toLowerCase().contains(search.toLowerCase()) 
    || name.toLowerCase().contains(search.toLowerCase());
}
```

```dart
searchCallback: (List<DropdownMenuEntry<Currency?>> entries, String query) {
  return entries.indexWhere((e) => e.value!.contains(query));
},
```

![](advanced.gif)

## Recap

We've played around with the recommended widgets for creating a selection box: DropdownMenu. We've created a nice and flexible currency picker, learning how to customize both looks and behaviour of the widget along the way. You can find the playground app source code in the [Fanci repository](https://github.com/astorDev/fanci/), and by the way... claps are appreciated! 👏

