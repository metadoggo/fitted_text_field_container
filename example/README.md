# Example app that uses fitted_text_field_container

This is an app that demonstrates using the `FittedTextFieldContainer` and  `AnimatedFittedTextFieldContainer` widgets of the `fitted_text_field_container` package.

## Getting Started

1. Clone the project
2. Get dependancies
3. Run the app

```sh
$ git clone https://github.com/huyffs/fitted_text_field_container.git
$ cd fitted_text_field_container/example
$ flutter packages get
$ flutter run
```

#### Unanimated example
The unanimated version uses `Container`
```dart
FittedTextFieldContainer(
    textField: TextField(
        style: TextStyle(fontSize: 48),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            prefixText: "£",
            hintText: "0",
        ),
    ),
)
```

#### Animated example
The animated version uses the `AnimatedContainer`, you can customise the grow/shrink animations as desired.
```dart
AnimatedFittedTextFieldContainer(
    growDuration: Duration(milliseconds: 300),
    shrinkDuration: Duration(milliseconds: 600),
    growCurve: Curves.easeOutCirc,
    shrinkCurve: Curves.easeInCirc,
    textField: TextField(
        style: TextStyle(fontSize: 48),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            prefixText: "£",
            hintText: "0",
        ),
    ),
)
```
