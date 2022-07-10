// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterTheme {
  static FlutterTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color primaryBtnText;
  Color lineColor;

  TextStyle get title1 => TextStyle(
        fontFamily: 'Headingpro',
        color: primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      );
  TextStyle get title2 => TextStyle(
        fontFamily: 'Headingpro',
        color: secondaryText,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontSize: 22,
      );
  TextStyle get subtitle1 => TextStyle(
        fontFamily: 'QuattrocentroSans',
        color: primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      );
  TextStyle get subtitle2 => TextStyle(
        fontFamily: 'QuattrocentroSans',
        color: secondaryText,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontSize: 22,
      );
  TextStyle get bodyText1 => TextStyle(
        fontFamily: 'QuattrocentroSans',
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18,
      );
  TextStyle get bodyText2 => TextStyle(
        fontFamily: 'QuattrocentroSans',
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        fontSize: 18,
      );
}

class LightModeTheme extends FlutterTheme {
  Color primaryColor = const Color(0x004B39EF);
  Color secondaryColor = const Color(0xFF39D2C0);
  Color tertiaryColor = const Color(0xFFEE8B60);
  Color alternate = const Color(0xFFFF5963);
  Color primaryBackground = const Color(0xFFF1F4F8);
  Color secondaryBackground = const Color(0xFFFFFFFF);
  Color primaryText = const Color(0xFF000000);
  Color secondaryText = const Color(0xFF57636C);
  Color primaryBtnText = Color(0xFFFFFFFF);
  Color lineColor = Color(0xFFE0E3E7);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = false,
    TextDecoration decoration,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
