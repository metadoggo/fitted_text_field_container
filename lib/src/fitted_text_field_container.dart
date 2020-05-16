import 'package:flutter/material.dart';

import 'utils.dart';

class FittedTextFieldContainer extends StatefulWidget {
  /// Creates a container to wrap a [child] `TextField`  and automatically resizes to fit the [child]'s text value
  ///
  /// ```dart
  /// FittedTextFieldContainer(
  ///   child: TextField(...),
  /// )
  /// ```

  /// The `TextField` to wrap
  final TextField child;

  /// The width of the `TextField.decoration.prefixIcon` if used
  final double prefixIconWidth;

  /// The width of the `TextField.decoration.suffixIcon` if used
  final double suffixIconWidth;

  /// The minimum width, if not set, the minimum width is 0 - i.e. there is no minimum
  final double minWidth;

  /// The maximum width, if not set, the minimum width is infinity - i.e. there is no maximum
  final double maxWidth;

  const FittedTextFieldContainer({
    Key key,
    @required this.child,
    this.prefixIconWidth = 48,
    this.suffixIconWidth = 48,
    this.minWidth,
    this.maxWidth,
  })  : assert(child != null),
        super(key: key);
  @override
  _FittedTextFieldContainerState createState() =>
      _FittedTextFieldContainerState();
}

class _FittedTextFieldContainerState extends State<FittedTextFieldContainer> {
  double _textFieldWidth;

  @override
  void initState() {
    assert(widget.child.controller != null);
    _textFieldWidth = _geTextFieldWidth();
    widget.child.controller.addListener(_onTextChanged);
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
        _textFieldWidth = width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _textFieldWidth,
      child: widget.child,
    );
  }
}
