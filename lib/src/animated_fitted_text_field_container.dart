import 'package:fitted_text_field_container/src/calculator.dart';
import 'package:flutter/material.dart';

import 'measurer.dart';

class AnimatedFittedTextFieldContainer extends StatefulWidget {
  /// Creates an animated container to wrap a [child] `TextField`  and
  /// automatically resizes to fit the [child]'s text value
  ///
  /// ```dart
  /// AnimatedFittedTextFieldContainer(
  ///   child: TextField(...),
  /// )
  /// ```

  /// The `TextField` to wrap - the `controller` must not be `null`.
  final TextField child;

  /// `Duration` for animating growth
  final Duration growDuration;

  /// `Duration` to use for animating shrinkage
  final Duration shrinkDuration;

  /// `Curve` to use for animating growth
  final Curve growCurve;

  /// `Curve` to use for animating shrinkage
  final Curve shrinkCurve;

  /// The calculator provides measured values that returns a width value
  final CalculateFunction calculator;

  /// The builder provides the `child` TextField to a function that returns a
  /// widget.
  final Widget Function(BuildContext context, TextField child)? builder;

  const AnimatedFittedTextFieldContainer({
    Key? key,
    required this.child,
    this.builder,
    CalculateFunction? calculator,
    Duration? growDuration,
    Duration? shrinkDuration,
    Curve? growCurve,
    Curve? shrinkCurve,
  })  : calculator = calculator ?? FittedTextFieldCalculator.fitVisible,
        growDuration = growDuration ?? const Duration(milliseconds: 300),
        shrinkDuration = shrinkDuration ?? const Duration(milliseconds: 600),
        growCurve = growCurve ?? Curves.easeOutCirc,
        shrinkCurve = shrinkCurve ?? Curves.easeInCirc,
        super(key: key);

  @override
  _AnimatedFittedTextFieldContainerState createState() =>
      _AnimatedFittedTextFieldContainerState();
}

class _AnimatedFittedTextFieldContainerState
    extends State<AnimatedFittedTextFieldContainer> {
  double? _textFieldWidth;
  late FittedTextFieldMeasurer _measurer;
  late Duration _duration;
  late Curve _curve;
  bool _didGrow = true;

  @override
  void initState() {
    assert(widget.child.controller != null);
    widget.child.controller!.addListener(_onTextChanged);
    _duration = widget.growDuration;
    _curve = widget.growCurve;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // When style is null, it defaults to `subtitle1` of current field.
    // See: https://api.flutter.dev/flutter/material/TextField/style.html
    final textStyle =
        widget.child.style ?? Theme.of(context).textTheme.subtitle1;

    _measurer = FittedTextFieldMeasurer.create(widget.child, textStyle);
    _textFieldWidth = widget.calculator(_measurer);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.child.controller!.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final width = widget.calculator(_measurer);
    if (width != _textFieldWidth) {
      setState(() {
        if (width > _textFieldWidth!) {
          if (!_didGrow) {
            _duration = widget.growDuration;
            _curve = widget.growCurve;
            _didGrow = true;
          }
        } else if (_didGrow) {
          _duration = widget.shrinkDuration;
          _curve = widget.shrinkCurve;
          _didGrow = false;
        }

        _textFieldWidth = width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _duration,
      curve: _curve,
      width: _textFieldWidth,
      child: widget.builder == null
          ? widget.child
          : widget.builder!(context, widget.child),
    );
  }
}
