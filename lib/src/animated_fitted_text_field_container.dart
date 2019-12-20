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

  /// The width of the `TextField.decoration.prefixIcon` if used
  final double prefixIconWidth;

  /// The width of the `TextField.decoration.suffixIcon` if used
  final double suffixIconWidth;

  /// The minimum width, if not set, the minimum width is 0 - i.e. there is no mimimum
  final double minWidth;

  /// The maximum width, if not set, the minimum width is infinity - i.e. there is no maximum
  final double maxWidth;

  const AnimatedFittedTextFieldContainer({
    Key key,
    this.child,
    this.growDuration = const Duration(milliseconds: 300),
    this.shrinkDuration = const Duration(milliseconds: 600),
    this.growCurve = Curves.easeOutCirc,
    this.shrinkCurve = Curves.easeInCirc,
    this.prefixIconWidth = 48,
    this.suffixIconWidth = 48,
    this.minWidth,
    this.maxWidth,
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
    _textFieldWidth = _geTextFieldWidth();
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


  double _geTextFieldWidth() {
    double width = calculateMaterialTextfieldWidth(widget.child,
        prefixIconWidth: widget.prefixIconWidth,
        suffixIconWidth: widget.suffixIconWidth);
    if (widget.minWidth != null && width < widget.minWidth) {
      width = widget.minWidth;
    }
    if (widget.maxWidth != null && width > widget.maxWidth) {
      width = widget.maxWidth;
    }
    return width;
  }

  void _onTextChanged() {
    final width = _geTextFieldWidth();
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
