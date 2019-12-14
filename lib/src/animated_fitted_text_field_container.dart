import 'package:flutter/material.dart';

import 'utils.dart';

class AnimatedFittedTextFieldContainer extends StatefulWidget {
  /// Creates an animated container to wrap a [child] `TextField`  and automatically resizes to fit the [child]'s text value
  ///
  /// ```dart
  /// AnimatedFittedTextFieldContainer(
  ///   child: TextField(...),
  /// )
  /// ```

  /// The `TextField` to wrap - the `controller` must not be `null`.
  final TextField child;

  /// `Duration` for animating gtowth
  final Duration growDuration;

  /// `Duration` to use for animating shrinkage
  final Duration shrinkDuration;

  /// `Curve` to use for animating growth
  final Curve growCurve;

  /// `Curve` to use for animating shrinkage
  final Curve shrinkCurve;

  const AnimatedFittedTextFieldContainer({
    Key key,
    this.child,
    this.growDuration = const Duration(milliseconds: 300),
    this.shrinkDuration = const Duration(milliseconds: 600),
    this.growCurve = Curves.easeOutCirc,
    this.shrinkCurve = Curves.easeInCirc,
  }) : super(key: key);
  @override
  _AnimatedFittedTextFieldContainerState createState() =>
      _AnimatedFittedTextFieldContainerState();
}

class _AnimatedFittedTextFieldContainerState
    extends State<AnimatedFittedTextFieldContainer> {
  double _textFieldWidth;
  Duration _duration;
  Curve _curve;

  @override
  void initState() {
    assert(widget.child.controller != null);
    _textFieldWidth = calculateMaterialTextfieldWidth(widget.child);
    widget.child.controller.addListener(_onTextChanged);
    _duration = widget.growDuration;
    _curve = widget.growCurve;
    super.initState();
  }

  @override
  void dispose() {
    widget.child.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    double width = calculateMaterialTextfieldWidth(widget.child);
    if (width != _textFieldWidth) {
      setState(() {
        if (width > _textFieldWidth) {
          _duration = widget.growDuration;
          _curve = widget.growCurve;
        } else {
          _duration = widget.shrinkDuration;
          _curve = widget.shrinkCurve;
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
      child: widget.child,
    );
  }
}
