import 'package:flutter/material.dart';

Size _calculateSize({
  @required String text,
  @required TextStyle style,
  @required TextAlign textAlign,
  @required StrutStyle strutStyle,
  @required int maxLines,
  @required TextDirection textDirection,
}) {
  if (text == null || text.isEmpty) {
    return Size(0, 0);
  }
  final painter = TextPainter(
    text: TextSpan(
      style: style,
      text: text,
    ),
    textAlign: textAlign,
    strutStyle: strutStyle,
    maxLines: maxLines,
    textDirection: textDirection,
  )..layout();
  return painter.size;
}

Size getPrefixTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.prefixText,
      style: textField.decoration.prefixStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection  ?? TextDirection.ltr,
    );

Size getSuffixTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.suffixText,
      style: textField.decoration.suffixStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection  ?? TextDirection.ltr,
    );

Size getHintTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.hintText,
      style: textField.decoration.hintStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection  ?? TextDirection.ltr,
    );

Size getLabelTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.labelText,
      style: textField.decoration.labelStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection  ?? TextDirection.ltr,
    );

Size getTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.controller.text,
      style: textField.style ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection  ?? TextDirection.ltr,
    );
