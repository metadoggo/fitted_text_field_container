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

  const FittedTextFieldContainer({Key key, @required this.child})
      : assert(child != null),
        super(key: key) ;
  @override
  _FittedTextFieldContainerState createState() =>
      _FittedTextFieldContainerState();
}

class _FittedTextFieldContainerState extends State<FittedTextFieldContainer> {
  double _textFieldWidth;

  @override
  void initState() {
    assert(widget.child.controller != null);
    _textFieldWidth = calculateMaterialTextfieldWidth(widget.child);
    widget.child.controller.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.child.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final double width = calculateMaterialTextfieldWidth(widget.child);
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
