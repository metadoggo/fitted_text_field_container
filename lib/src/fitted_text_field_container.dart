import 'package:fitted_text_field_container/src/calculator.dart';
import 'package:flutter/material.dart';

import 'measurer.dart';

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
    this.builder,
    CalculateFunction calculator,
  })  : assert(child != null),
        calculator = calculator ?? FittedTextFieldCalculator.fitVisible,
        super(key: key);

  @override
  _FittedTextFieldContainerState createState() =>
      _FittedTextFieldContainerState();
}

class _FittedTextFieldContainerState extends State<FittedTextFieldContainer> {
  double _textFieldWidth;
  FittedTextFieldMeasurer _measurer;

  @override
  void initState() {
    assert(widget.child.controller != null);
    widget.child.controller.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // When style is null, it defaults to `subtitle1` of current field.
    // See: https://api.flutter.dev/flutter/material/TextField/style.html
    final textStyle = widget.child.style ?? Theme.of(context).textTheme.subhead;

    _measurer = FittedTextFieldMeasurer.create(widget.child, textStyle);
    _textFieldWidth = widget.calculator(_measurer);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.child.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final width = widget.calculator(_measurer);
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
