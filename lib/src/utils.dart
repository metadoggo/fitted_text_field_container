import 'package:flutter/material.dart';

/// Calculates the text's width with the [style], [textAlign], [strutStyle] and [textDirection] properties applied
double _getTextWidth({
  final String text,
  final TextStyle style,
  final TextAlign textAlign = TextAlign.start,
  final StrutStyle strutStyle,
  final TextDirection textDirection = TextDirection.ltr,
}) {
  if (text == null || text.isEmpty) {
    return 0;
  }
  final TextSpan span = TextSpan(
    style: style,
    text: text,
  );
  final TextPainter painter = TextPainter(
    text: span,
    textAlign: textAlign,
    strutStyle: strutStyle,
    textDirection: textDirection,
  );
  painter.layout();
  return painter.width;
}

/// Returns the width of the textfield's `text` + `prefixText` + `suffixText`
double calculateMaterialTextfieldWidth(TextField tf) {
  final double prefixWidth = _getTextWidth(
    text: tf.decoration.prefixText,
    style: tf.decoration.prefixStyle ?? tf.style,
  );
  final double suffixWidth = _getTextWidth(
    text: tf.decoration.suffixText,
    style: tf.decoration.suffixStyle ?? tf.style,
  );
  // Magic number 3 that somehow prevents scrolling in the input field
  double width = prefixWidth + suffixWidth + 3;
  if (tf.controller.text.isEmpty) {
    width += _getTextWidth(
      text: tf.decoration.hintText,
      style: tf.decoration.hintStyle ?? tf.style,
    );
  } else {
    width += _getTextWidth(
      text: tf.controller.text,
      style: tf.style,
      textAlign: tf.textAlign ?? TextAlign.start,
      strutStyle: tf.strutStyle,
      textDirection: tf.textDirection ?? TextDirection.ltr,
    );
  }
  return width;
}
