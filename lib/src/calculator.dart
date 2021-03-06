import 'dart:math' show max;

import 'package:fitted_text_field_container/src/measurer.dart';

typedef double CalculateFunction(FittedTextFieldMeasurer measurer);

class FittedTextFieldCalculator {
  /// FittedTextFieldCalculator contains calculators for common use-cases

  /// fitAll fits content, label and hint texts
  static double fitAll(FittedTextFieldMeasurer m) =>
      m.fixedWidths +
      max<double>(m.labelWidth, max<double>(m.hintWidth, m.textWidth));

  /// fitVisible fits the visible content & decorations (i.e. it collapses to
  /// the content/label's width when hint text disappears)
  static double fitVisible(FittedTextFieldMeasurer m) =>
      m.fixedWidths +
      max<double>(m.labelWidth,
          m.textField.controller.text.isEmpty ? m.hintWidth : m.textWidth);

  /// fitVisibleWithPadding in addition to fitting visible content it adds a
  /// fixed padding value
  static CalculateFunction fitVisibleWithPadding(double padding) =>
      (FittedTextFieldMeasurer m) =>
          padding +
          m.fixedWidths +
          max<double>(m.labelWidth,
              m.textField.controller.text.isEmpty ? m.hintWidth : m.textWidth);

  /// fitVisibleWithRange in addition to fitting visible content it enforces
  /// a minimum and (optional) maximum width
  static CalculateFunction fitVisibleWithRange(double minWidth,
          [double maxWidth]) =>
      (FittedTextFieldMeasurer m) {
        final width = m.fixedWidths +
            max<double>(
                m.labelWidth,
                m.textField.controller.text.isEmpty
                    ? m.hintWidth
                    : m.textWidth);
        if (width < minWidth) {
          return minWidth;
        } else if (maxWidth != null && width > maxWidth) {
          return maxWidth;
        } else {
          return width;
        }
      };
}
