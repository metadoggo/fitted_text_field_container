import 'package:flutter/material.dart';

class TextFieldMeasurer {
  TextFieldMeasurer._({
    required this.textField,
    required this.textStyle,
    required this.hintWidth,
    required this.labelWidth,
    required this.fixedWidths,
  });

  factory TextFieldMeasurer.create(TextField textField, TextStyle? textStyle) {
    final prefixWidth = _getPrefixTextSize(textField, textStyle).width;
    final suffixWidth = _getSuffixTextSize(textField, textStyle).width;
    final hintWidth = _getHintTextSize(textField, textStyle).width;
    final labelWidth = _getLabelTextSize(textField, textStyle).width;
    final paddingWidth = textField.decoration!.contentPadding != null
        ? textField.decoration!.contentPadding!.collapsedSize.width
        : 0;
    // Add enough space for the cursor to prevent it being positined onto the
    // next line in a multiline textfield and scrolled in a single-line text
    // field
    final cursorWidth = textField.cursorWidth + 1;

    return TextFieldMeasurer._(
      textField: textField,
      textStyle: textStyle,
      hintWidth: hintWidth,
      labelWidth: labelWidth,
      fixedWidths: prefixWidth + suffixWidth + paddingWidth + cursorWidth,
    );
  }

  final TextField textField;
  final TextStyle? textStyle;
  final double hintWidth;
  final double labelWidth;
  final double fixedWidths;

  static Size _calculateSize({
    required String? text,
    required TextStyle? style,
    required TextAlign textAlign,
    required StrutStyle? strutStyle,
    required int? maxLines,
    required TextDirection textDirection,
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

  static Size _getPrefixTextSize(TextField textField,
          [TextStyle? defaultStyle]) =>
      _calculateSize(
        text: textField.decoration!.prefixText,
        style: textField.decoration!.prefixStyle ?? defaultStyle,
        textAlign: textField.textAlign,
        strutStyle: textField.strutStyle,
        maxLines: textField.maxLines,
        textDirection: textField.textDirection ?? TextDirection.ltr,
      );

  static Size _getSuffixTextSize(TextField textField,
          [TextStyle? defaultStyle]) =>
      _calculateSize(
        text: textField.decoration!.suffixText,
        style: textField.decoration!.suffixStyle ?? defaultStyle,
        textAlign: textField.textAlign,
        strutStyle: textField.strutStyle,
        maxLines: textField.maxLines,
        textDirection: textField.textDirection ?? TextDirection.ltr,
      );

  static Size _getHintTextSize(TextField textField, [TextStyle? defaultStyle]) =>
      _calculateSize(
        text: textField.decoration!.hintText,
        style: textField.decoration!.hintStyle ?? defaultStyle,
        textAlign: textField.textAlign,
        strutStyle: textField.strutStyle,
        maxLines: textField.maxLines,
        textDirection: textField.textDirection ?? TextDirection.ltr,
      );

  static Size _getLabelTextSize(TextField textField,
          [TextStyle? defaultStyle]) =>
      _calculateSize(
        text: textField.decoration!.labelText,
        style: textField.decoration!.labelStyle ?? defaultStyle,
        textAlign: textField.textAlign,
        strutStyle: textField.strutStyle,
        maxLines: textField.maxLines,
        textDirection: textField.textDirection ?? TextDirection.ltr,
      );

  double get textWidth => textField.controller!.text.isNotEmpty
      ? _calculateSize(
          text: textField.controller!.text,
          style: textField.style ?? textStyle,
          textAlign: textField.textAlign,
          strutStyle: textField.strutStyle,
          maxLines: textField.maxLines,
          textDirection: textField.textDirection ?? TextDirection.ltr,
        ).width
      : 0;
}
