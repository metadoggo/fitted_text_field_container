import 'package:flutter/material.dart';

extension MeasurableTextField on TextField {
  double _calculateWidth(String text, TextStyle style) {
    if (text == null || text.isEmpty) {
      return 0;
    }
    final TextPainter painter = TextPainter(
      text: TextSpan(
        style: style ?? this.style,
        text: text,
      ),
      // textAlign: textAlign,
      // strutStyle: strutStyle,
      textDirection: textDirection ?? TextDirection.ltr,
    )..layout();
    return painter.width;
  }

  double get prefixTextWidth =>
      _calculateWidth(this.decoration.prefixText, this.decoration.prefixStyle);
  double get suffixTextWidth =>
      _calculateWidth(this.decoration.suffixText, this.decoration.suffixStyle);
  double get hintTextWidth =>
      _calculateWidth(this.decoration.hintText, this.decoration.hintStyle);
  double get labelTextWidth =>
      _calculateWidth(this.decoration.labelText, this.decoration.labelStyle);
  double get textWidth => _calculateWidth(this.controller.text, this.style);
}
