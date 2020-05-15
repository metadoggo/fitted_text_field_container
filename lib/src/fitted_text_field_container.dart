import 'dart:math';

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

  /// The minimum width, if not set, the minimum width is 0 - i.e. there is no mimimum
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
  double _prefixWidth;
  double _suffixWidth;
  double _hintWidth;
  double _labelWidth;
  double _fixedWidth;
  double _textFieldWidth;

  @override
  void initState() {
    assert(widget.child.controller != null);
    widget.child.controller.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _prefixWidth = widget.child.prefixTextWidth.width;
    _suffixWidth = widget.child.suffixTextWidth.width;
    _hintWidth = widget.child.hintTextWidth.width;
    _labelWidth = widget.child.labelTextWidth.width;
    _fixedWidth = _prefixWidth + _suffixWidth;

    if (widget.child.decoration.prefixIcon != null) {
      _fixedWidth += widget.prefixIconWidth;
    }
    if (widget.child.decoration.suffixIcon != null) {
      _fixedWidth += widget.suffixIconWidth;
    }

    _fixedWidth += 3; // 3 is a magic number that makes it work

    _textFieldWidth = _geTextFieldWidth();
    
    super.didChangeDependencies();
  }


  @override
  void dispose() {
    widget.child.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  double _geTextFieldWidth() {
    double textWidth = widget.child.textWidth.width;


    double width = max(max(textWidth, _hintWidth), _labelWidth) + _fixedWidth;

    if (widget.child.decoration.prefixIcon != null) {
      width += widget.prefixIconWidth;
    }
    if (widget.child.decoration.suffixIcon != null) {
      width += widget.suffixIconWidth;
    }

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
