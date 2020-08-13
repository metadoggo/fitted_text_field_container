# Fitted TextField Container

A `Container` that automatically resizes it's width to fit the containing `TextField`'s text value.

Read the short blog: https://medium.com/@huyffs/fitted-textfield-container-for-flutter-c9c63644441c

## Usage

### FittedTextFieldContainer

| Param        | Type                                                     | Default      | Description                                                                                                  |
|--------------|----------------------------------------------------------|--------------|--------------------------------------------------------------------------------------------------------------|
| `child`      | `TextField`                                              | * _required_ | The `TextField` to fit                                                                                       |
| `calculator` | `double Function(TextFieldMeasurer measurer)`            | `null`       | A function to calculate the width                                                                            |
| `builder`    | `Widget Function(BuildContext context, TextField child)` | `null`       | A builder that can be used to build complex layouts. The `child` TextField is provided to the build function |

#### Example

```dart
FittedTextFieldContainer(
    child: TextField(
        controller: someTextEditingController,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            prefixText: "£",
            labelText: "Amount",
        ),
    ),
)
```

### AnimatedFittedTextFieldContainer
| Param            | Type                                                     | Default                       | Description                                                                                                  |
|------------------|----------------------------------------------------------|-------------------------------|--------------------------------------------------------------------------------------------------------------|
| `child`          | `TextField`                                              | * _required_                  | The `TextField` to fit                                                                                       |
| `calculator`     | `double Function(TextFieldMeasurer measurer)`            | `null`                        | A function to calculate the width                                                                            |
| `growDuration`   | `Duration`                                               | `Duration(milliseconds: 300)` | Duration to animate the container's width when `TextField` grows                                             |
| `shrinkDuration` | `Duration`                                               | `Duration(milliseconds: 600)` | Duration to animate the container's width when `TextField` shrinks                                           |
| `growCurve`      | `Curve`                                                  | `Curves.easeOutCirc`          | The curve to use in the grow animation                                                                       |
| `shrinkCurve`    | `Curve`                                                  | `Curves.easeInCirc`           | The curve to use in the shrink animation                                                                     |
| `builder`        | `Widget Function(BuildContext context, TextField child)` | `null`                        | A builder that can be used to build complex layouts. The `child` TextField is provided to the build function |

#### Example

```dart
AnimatedFittedTextFieldContainer(
    growDuration: Duration(milliseconds: 300),
    shrinkDuration: Duration(milliseconds: 600),
    growCurve: Curves.easeOutCirc,
    shrinkCurve: Curves.easeInCirc,
    child: TextField(
        controller: someTextEditingController,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            prefixText: "£",
            labelText: "Amount",
        ),
    ),
)
```

### Using the custom width calculator
```dart
AnimatedFittedTextFieldContainer(
    calculator: (m) =>
        m.fixedWidths +
        max(m.labelWidth, max(m.hintWidth, m.textWidth)),
    child: TextField(
        controller: someTextEditingController,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            hintText: "Width of hint text",
        ),
    ),
)
```

### Using the `builder`
```dart
AnimatedFittedTextFieldContainer(
    child: TextField(
        controller: someTextEditingController,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            labelText: "Twinkle twinkle",
        ),
    ),
    builder: (context, child) => Container(
        child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
                child,
                Positioned(
                    top: 0,
                    right: -22,
                    child: _aniWholePoundCtl.text.isEmpty
                        ? Icon(Icons.star_border)
                        : Icon(Icons.star, color: Colors.amber),
                ),
            ],
        ),
    ),
)
```

## Contribute

Pull requests are welcome!

## Licence

MIT License

Copyright (c) 2020 Huy Dinh