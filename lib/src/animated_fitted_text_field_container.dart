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

  /// `Duration` for animating growth
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

  /// The minimum width, default is 0 - which makes the TextField invisible if the TextField
  /// doesn't include properties that takes up space (such as labelText, prefixIcon, etc).
  final double minWidth;

  /// The maximum width, defaults to `double.infinity` - i.e. there is no maximum
  final double maxWidth;

  /// The builder provides the `child` TextField to a function that returns a widget.
  final Widget Function(BuildContext context, TextField child) builder;

  const AnimatedFittedTextFieldContainer({
    Key key,
    this.child,
    this.growDuration = const Duration(milliseconds: 300),
    this.shrinkDuration = const Duration(milliseconds: 600),
    this.growCurve = Curves.easeOutCirc,
    this.shrinkCurve = Curves.easeInCirc,
    this.prefixIconWidth = 48,
    this.suffixIconWidth = 48,
    this.minWidth = 0,
    this.maxWidth = double.infinity,
    this.builder,
  }) : super(key: key);
  @override
  _AnimatedFittedTextFieldContainerState createState() =>
      _AnimatedFittedTextFieldContainerState();
}

class _AnimatedFittedTextFieldContainerState
    extends State<AnimatedFittedTextFieldContainer> {
  double _prefixWidth;
  double _suffixWidth;
  double _hintWidth;
  double _labelWidth;
  double _fixedWidth;
  double _textFieldWidth;
  Duration _duration;
  Curve _curve;
  TextStyle _defaultTextStyle;

  @override
  void initState() {
    assert(widget.child.controller != null);
    widget.child.controller.addListener(_onTextChanged);
    _duration = widget.growDuration;
    _curve = widget.growCurve;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _prefixWidth = widget.child.getPrefixTextSize(_defaultTextStyle).width;
    _suffixWidth = widget.child.getSuffixTextSize(_defaultTextStyle).width;
    _hintWidth = widget.child.getHintTextSize(_defaultTextStyle).width;
    _labelWidth = widget.child.getLabelTextSize(_defaultTextStyle).width;
    _fixedWidth = _prefixWidth + _suffixWidth;
    _fixedWidth = _prefixWidth + _suffixWidth;

    if (widget.child.decoration.prefixIcon != null) {
      _fixedWidth += widget.prefixIconWidth;
    }
    if (widget.child.decoration.suffixIcon != null) {
      _fixedWidth += widget.suffixIconWidth;
    }

    // Add enough space for the cursor to prevent it being positined onto the next line
    // in a multiline textfield and scrolled in a single-line text field.
    _fixedWidth += widget.child.cursorWidth + 1;

    // When style is null, it defaults to `subtitle1` of current field.
    // See: https://api.flutter.dev/flutter/material/TextField/style.html
    _defaultTextStyle =
        widget.child.style ?? Theme.of(context).textTheme.subtitle1;
    _textFieldWidth = _geTextFieldWidth();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.child.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  double _geTextFieldWidth() {
    double textWidth = widget.child.getTextSize(_defaultTextStyle).width;
    double width = textWidth > _hintWidth ? textWidth : _hintWidth;
    if (_labelWidth > width) {
      width = _labelWidth;
    }
    width += _fixedWidth;

    if (width < widget.minWidth) {
      width = widget.minWidth;
    }
    if (width > widget.maxWidth) {
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
      // widget.child.controller.selection = widget.child.controller.selection.copyWith();
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
          : widget.builder(context, widget.child),
    );
  }
}
