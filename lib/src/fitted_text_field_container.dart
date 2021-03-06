import 'dart:math';

import 'package:flutter/material.dart';

import 'utils.dart';

typedef double CalculateFunction(TextFieldMeasurer measurer);

class FittedTextFieldContainer extends StatefulWidget {
  /// Creates an animated container to wrap a [child] `TextField`  and
  /// automatically resizes to fit the [child]'s text value
  ///
  /// ```dart
  /// FittedTextFieldContainer(
  ///   child: TextField(...),
  /// )
  /// ```

  /// The `TextField` to wrap
  final TextField child;

  /// The calculator provides measured values that returns a width value
  final CalculateFunction calculator;

  /// The builder provides the `child` TextField to a function that returns a
  /// widget.
  final Widget Function(BuildContext context, TextField child) builder;

  const FittedTextFieldContainer({
    Key key,
    @required this.child,
    this.calculator,
    this.builder,
  })  : assert(child != null),
        super(key: key);

  @override
  _FittedTextFieldContainerState createState() =>
      _FittedTextFieldContainerState();

  static CalculateFunction defaultCalculator = (m) =>
      m.fixedWidths +
      max(m.labelWidth,
          m.textField.controller.text.isEmpty ? m.hintWidth : m.textWidth);
}

class _FittedTextFieldContainerState extends State<FittedTextFieldContainer> {
  CalculateFunction _calculator;
  double _textFieldWidth;
  TextFieldMeasurer _measurer;

  @override
  void initState() {
    assert(widget.child.controller != null);
    _calculator =
        widget.calculator ?? FittedTextFieldContainer.defaultCalculator;
    widget.child.controller.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // When style is null, it defaults to `subtitle1` of current field.
    // See: https://api.flutter.dev/flutter/material/TextField/style.html
    final textStyle = widget.child.style ?? Theme.of(context).textTheme.subhead;

    _measurer = TextFieldMeasurer.create(widget.child, textStyle);
    _textFieldWidth = _calculator(_measurer);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.child.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final width = _calculator(_measurer);
    if (width != _textFieldWidth) {
      setState(() {
        _textFieldWidth = width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _textFieldWidth,
      child: widget.builder == null
          ? widget.child
          : widget.builder(context, widget.child),
    );
  }
}
