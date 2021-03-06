## 1.3.1+1
* Fixed README

## 1.3.1
* Updated README
* Added width calculators for common use-cases

## 1.3.0
* Added `calculator` property to allow custom width calculations 
* **Breaking Change.** Removed `minWidth`, `maxWidth`, `prefixIconWidth`, `suffixIconWidth` properties (they can be replaced with the custom width calculator)
* **Breaking Change.** Defaults to collapse width to visible text instead of keeping the hint text (Thanks [AdamJonsson](https://github.com/AdamJonsson) for PR [#2](https://github.com/huyffs/fitted_text_field_container/pull/2))
* Include padding into calculations (Thanks [David King](https://github.com/oodavid) for PR [#3](https://github.com/huyffs/fitted_text_field_container/pull/3))

## 1.2.1
* Fixed exception thrown when `textDirection` is not set
* Fixed incorect calculations due to default stules not being available durint initialisation

## 1.2.0
* Added `builder` for building complex layouts
* Fixed calculations to remove the need for a magic number
* Code tidy-ups and optimisations which should improve performance by a tiny tiny bit
* Fixed docs and typos (Thanks [jpnurmi](https://github.com/jpnurmi) for PR [#1](https://github.com/huyffs/fitted_text_field_container/pull/1))

## 1.1.0
* Added `prefixIconWidth` for specifying the width of the prefix icon (if used)
* Added `suffixIconWidth` for specifying the width of the suffix icon (if used)
* Added `minWidth` property for specifying a minimum width
* Added `maxWidth` property for specifying a maximum width
* Minimum width takes `labelText` and `hintText` into account (if specified) 

## 1.0.0+3
* Updated demo & documentation

## 1.0.0+2
* Formatted code

## 1.0.0+1
* Initial release - take 2

## 1.0.0
* Initial release