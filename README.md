# Fitted TextField Container

A `Container` that automatically resizes it's width to fit the containing `TextField`'s text value.

## Usage

### FittedTextFieldContainer

|  |  |  |
|--|--|--|
|Param|Default|Description|
|`child`||The `TextField` to contain|
|  |  |  |

#### Example

```dart
FittedTextFieldContainer(
    child: TextField(
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

Here I've used `hintText: "0"` to keep the textfield from becoming very narrow when the `TextField` is empty.

### AnimatedFittedTextFieldContainer
|  |  |  |
|--|--|--|
|Param|Default|Description|
|`growDuration`|`Duration(milliseconds: 300)`|Duration to animate the container's width when text is longer|
|`shrinkDuration`|`Duration(milliseconds: 600)`|Duration to animate the container's width when text is shorter|
|`growCurve`|`Curves.easeOutCirc`|The curve to use in the grow animation|
|`shrinkCurve`|`Curves.easeInCirc`|The curve to use in the shrink animation|
|`child`||The `TextField` to contain|
|  |  |  |

#### Example

```dart
AnimatedFittedTextFieldContainer(
    growDuration: Duration(milliseconds: 300),
    shrinkDuration: Duration(milliseconds: 600),
    growCurve: Curves.easeOutCirc,
    shrinkCurve: Curves.easeInCirc,
    child: TextField(
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

Again, `hintText: "0"` helps to keep the textfield from becoming very narrow when the `TextField` is empty.

## Contribute

Pull requests are welcome!

## Licence

MIT License

Copyright (c) 2020 Huy Dinh