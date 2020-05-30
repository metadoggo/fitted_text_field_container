import 'package:flutter/material.dart';

Size _calculateSize({
  String text,
  TextStyle style,
  TextAlign textAlign,
  StrutStyle strutStyle,
  int maxLines,
  TextDirection textDirection = TextDirection.ltr,
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
      textDirection: textField.textDirection,
    );

Size getSuffixTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.suffixText,
      style: textField.decoration.suffixStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection,
    );

Size getHintTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.hintText,
      style: textField.decoration.hintStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection,
    );

Size getLabelTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.decoration.labelText,
      style: textField.decoration.labelStyle ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection,
    );

Size getTextSize(TextField textField, [TextStyle defaultStyle]) =>
    _calculateSize(
      text: textField.controller.text,
      style: textField.style ?? defaultStyle,
      textAlign: textField.textAlign,
      strutStyle: textField.strutStyle,
      maxLines: textField.maxLines,
      textDirection: textField.textDirection,
    );
