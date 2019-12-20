# Fitted TextField Container

A `Container` that automatically resizes it's width to fit the containing `TextField`'s text value.

Read the short blog: https://medium.com/@huyffs/fitted-textfield-container-for-flutter-c9c63644441c

## Usage

### FittedTextFieldContainer

| Param             | Type        | Default      | Description                                                                                                    |
|-------------------|-------------|--------------|----------------------------------------------------------------------------------------------------------------|
| `child`           | `TextField` | * _required_ | The `TextField` to fit                                                                                         |
| `prefixIconWidth` | `double`    | `48`         | Width of the `prefxiIcon` (if used)                                                                            |
| `suffixIconWidth` | `double`    | `48`         | Width of the `suffxiIcon` (if used)                                                                            |
| `prefixIconWidth` | `double`    | `null`       | Minimum width - `null` means there is no hard minimum width - it will depend on the `labelText` and `hintText` |
| `prefixIconWidth` | `double`    | `null`       | Maximum width - `null` means the maximum width is only contrained by the parent widget                         |

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
| Param             | Type        | Default                       | Description                                                                                                    |
|-------------------|-------------|-------------------------------|----------------------------------------------------------------------------------------------------------------|
| `child`           | `TextField` |  * _required_                 | The `TextField` to fit                                                                                         |
| `growDuration`    | `Duration`  | `Duration(milliseconds: 300)` | Duration to animate the container's width when `TextField` grows                                               |
| `shrinkDuration`  | `Duration`  | `Duration(milliseconds: 600)` | Duration to animate the container's width when `TextField` shrinks                                             |
| `growCurve`       | `Curve`     | `Curves.easeOutCirc`          | The curve to use in the grow animation                                                                         |
| `shrinkCurve`     | `Curve`     | `Curves.easeInCirc`           | The curve to use in the shrink animation                                                                       |
| `prefixIconWidth` | `double`    | `48`                          | Width of the `prefixIcon` (if used)                                                                            |
| `suffixIconWidth` | `double`    | `48`                          | Width of the `suffixIcon` (if used)                                                                            |
| `prefixIconWidth` | `double`    | `null`                        | Minimum width - `null` means there is no hard minimum width - it will depend on the `labelText` and `hintText` |
| `prefixIconWidth` | `double`    | `null`                        | Maximum width - `null` means the maximum width is only contrained by the parent widget                         |


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

## Contribute

Pull requests are welcome!

## Licence

MIT License

Copyright (c) 2020 Huy Dinh