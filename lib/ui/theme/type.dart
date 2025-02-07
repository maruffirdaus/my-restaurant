import 'package:flutter/material.dart';

TextTheme getTextTheme(BuildContext context) {
  TextTheme baseline = Theme.of(context).textTheme;

  return TextTheme(
    displayLarge: baseline.displayLarge?.copyWith(fontFamily: 'Nunito'),
    displayMedium: baseline.displayMedium?.copyWith(fontFamily: 'Nunito'),
    displaySmall: baseline.displaySmall?.copyWith(fontFamily: 'Nunito'),
    headlineLarge: baseline.headlineLarge?.copyWith(fontFamily: 'Nunito'),
    headlineMedium: baseline.headlineMedium?.copyWith(fontFamily: 'Nunito'),
    headlineSmall: baseline.headlineSmall?.copyWith(fontFamily: 'Nunito'),
    titleLarge: baseline.titleLarge?.copyWith(fontFamily: 'Nunito'),
    titleMedium: baseline.titleMedium?.copyWith(fontFamily: 'Nunito'),
    titleSmall: baseline.titleSmall?.copyWith(fontFamily: 'Nunito'),
    bodyLarge: baseline.bodyLarge?.copyWith(fontFamily: 'Nunito'),
    bodyMedium: baseline.bodyMedium?.copyWith(fontFamily: 'Nunito'),
    bodySmall: baseline.bodySmall?.copyWith(fontFamily: 'Nunito'),
    labelLarge: baseline.labelLarge?.copyWith(fontFamily: 'Nunito'),
    labelMedium: baseline.labelMedium?.copyWith(fontFamily: 'Nunito'),
    labelSmall: baseline.labelSmall?.copyWith(fontFamily: 'Nunito'),
  );
}