# Fitted TextField Container

A `Container` that automatically resizes it's width to fit the containing `TextField`'s text value.

Read the short blog: https://medium.com/@huyffs/fitted-textfield-container-for-flutter-c9c63644441c

## Usage

### FittedTextFieldContainer

| Param             | Type                                                     | Default           | Description                                                                                                    |
|-------------------|----------------------------------------------------------|-------------------|----------------------------------------------------------------------------------------------------------------|
| `child`           | `TextField`                                              | * _required_      | The `TextField` to fit                                                                                         |
| `prefixIconWidth` | `double`                                                 | `48`              | Width of the `prefixIcon` (if used)                                                                            |
| `suffixIconWidth` | `double`                                                 | `48`              | Width of the `suffixIcon` (if used)                                                                            |
| `minWidth`        | `double`                                                 | `0`               | Minimum width - `0` means there is no minimum width - the width will be affected by `labelText` and `hintText` |
| `maxWidth`        | `double`                                                 | `double.infinity` | Maximum width - `double.infinity` means that the maximum width is only constrained by the parent widget        |
| `builder`         | `Widget Function(BuildContext context, TextField child)` | `null`            | A builder that can be used to build complex layouts. The `child` TextField is provided to the build function   |

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
| Param             | Type                                                     | Default                       | Description                                                                                                    |
|-------------------|----------------------------------------------------------|-------------------------------|----------------------------------------------------------------------------------------------------------------|
| `child`           | `TextField`                                              | * _required_                  | The `TextField` to fit                                                                                         |
| `growDuration`    | `Duration`                                               | `Duration(milliseconds: 300)` | Duration to animate the container's width when `TextField` grows                                               |
| `shrinkDuration`  | `Duration`                                               | `Duration(milliseconds: 600)` | Duration to animate the container's width when `TextField` shrinks                                             |
| `growCurve`       | `Curve`                                                  | `Curves.easeOutCirc`          | The curve to use in the grow animation                                                                         |
| `shrinkCurve`     | `Curve`                                                  | `Curves.easeInCirc`           | The curve to use in the shrink animation                                                                       |
| `prefixIconWidth` | `double`                                                 | `48`                          | Width of the `prefixIcon` (if used)                                                                            |
| `suffixIconWidth` | `double`                                                 | `48`                          | Width of the `suffixIcon` (if used)                                                                            |
| `minWidth`        | `double`                                                 | `0`                           | Minimum width - `0` means there is no minimum width - the width will be affected by `labelText` and `hintText` |
| `maxWidth`        | `double`                                                 | `double.infinity`             | Maximum width - `double.infinity` means that the maximum width is only constrained by the parent widget        |
| `builder`         | `Widget Function(BuildContext context, TextField child)` | `null`                        | A builder that can be used to build complex layouts. The `child` TextField is provided to the build function   |

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

### Using the `builder`
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