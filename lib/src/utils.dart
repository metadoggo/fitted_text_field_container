import 'package:flutter/material.dart';

extension MeasurableTextField on TextField {
  Size _calculateWidth(String text, TextStyle style) {
    if (text == null || text.isEmpty) {
      return Size(0, 0);
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
    return Size(painter.width, painter.height);
  }

  Size get prefixTextWidth =>
      _calculateWidth(this.decoration.prefixText, this.decoration.prefixStyle);
  Size get suffixTextWidth =>
      _calculateWidth(this.decoration.suffixText, this.decoration.suffixStyle);
  Size get hintTextWidth =>
      _calculateWidth(this.decoration.hintText, this.decoration.hintStyle);
  Size get labelTextWidth =>
      _calculateWidth(this.decoration.labelText, this.decoration.labelStyle);
  Size get textWidth => _calculateWidth(this.controller.text, this.style);
}
