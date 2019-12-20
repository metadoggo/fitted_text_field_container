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

/// Returns the width of the textfield's `text` with prefix and suffix included
double calculateMaterialTextfieldWidth(
  TextField tf, {
  double prefixIconWidth,
  double suffixIconWidth,
}) {
  // Magic number 3 that somehow prevents scrolling in the input field
  double width = 3;
  if (tf.decoration.prefixText != null) {
    width += _getTextWidth(
      text: tf.decoration.prefixText,
      style: tf.decoration.prefixStyle ?? tf.style,
    );
  } else if (tf.decoration.prefixIcon != null && prefixIconWidth != null) {
    width += prefixIconWidth;
  }
  if (tf.decoration.suffixText != null) {
    width += _getTextWidth(
      text: tf.decoration.suffixText,
      style: tf.decoration.suffixStyle ?? tf.style,
    );
  } else if (tf.decoration.suffixIcon != null && suffixIconWidth != null) {
    width += suffixIconWidth;
  }
  double textWidth = 0;
  if (tf.controller.text.isNotEmpty) {
    textWidth = _getTextWidth(
      text: tf.controller.text,
      style: tf.style,
      textAlign: tf.textAlign ?? TextAlign.start,
      strutStyle: tf.strutStyle,
      textDirection: tf.textDirection ?? TextDirection.ltr,
    );
  }
  if (tf.decoration.labelText != null && tf.decoration.labelText.isNotEmpty) {
    final labelWidth = _getTextWidth(
      text: tf.decoration.labelText,
      style: tf.decoration.labelStyle ?? tf.style,
    );
    if (labelWidth > textWidth) {
      textWidth = labelWidth;
    }
  }
  if (tf.decoration.hintText != null && tf.decoration.hintText.isNotEmpty) {
    final hintWidth = _getTextWidth(
      text: tf.decoration.hintText,
      style: tf.decoration.hintStyle ?? tf.style,
    );
    if (hintWidth > textWidth) {
      textWidth = hintWidth;
    }
  }

  return width + textWidth;
}
