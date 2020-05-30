import 'package:flutter/material.dart';

extension MeasurableTextField on TextField {
  Size _calculateSize(String text, TextStyle style) {
    if (text == null || text.isEmpty) {
      return Size(0, 0);
    }
    final painter = TextPainter(
      text: TextSpan(
        style: style ?? this.style,
        text: text,
      ),
      textAlign: textAlign,
      strutStyle: strutStyle,
      maxLines: this.maxLines,
      textDirection: textDirection ?? TextDirection.ltr,
    )..layout();
    return painter.size;
  }

  Size getPrefixTextSize([TextStyle defaultStyle]) => _calculateSize(
      this.decoration.prefixText, this.decoration.prefixStyle ?? defaultStyle);

  Size getSuffixTextSize([TextStyle defaultStyle]) => _calculateSize(
      this.decoration.suffixText, this.decoration.suffixStyle ?? defaultStyle);

  Size getHintTextSize([TextStyle defaultStyle]) => _calculateSize(
      this.decoration.hintText, this.decoration.hintStyle ?? defaultStyle);

  Size getLabelTextSize([TextStyle defaultStyle]) => _calculateSize(
      this.decoration.labelText, this.decoration.labelStyle ?? defaultStyle);

  Size getTextSize([TextStyle defaultStyle]) =>
      _calculateSize(this.controller.text, this.style ?? defaultStyle);
}
