import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension IntExtensions on int? {
  /// Leaves given height of space
  Widget get height => SizedBox(height: this?.toDouble());

  /// Leaves given width of space
  Widget get width => SizedBox(width: this?.toDouble());
}

class Style {
  // Style._();

  // static const Color primary = Color(0xff012751);
  static const Color subText = Color(0xff4D657F);
  static const Color secondary = Color(0xffD6D6D8);
  static const Color secondaryDark = Color(0xffA3A3A4);
  static const Color textColor = Color(0xff52677C);
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);

  static const Color lightText = Color(0xff52677C);

  static const Color darkText = Color(0xFF3A5160);
  static const Color darkerText = Color(0xFF313A44);

  static const Color textFieldBackground = Color(0xffEFF3FE);

  static const List<Color> randomColorList = [
    Color(0xffAB8FF4),
    Color(0xffE39AE0),
    Color(0xff85ADEA),
    Color(0xff66D3C5),
  ];

  //AKA Value style
  static TextStyle inputFieldTextStyle(context) =>
      Theme.of(context).textTheme.subtitle2!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
            letterSpacing: 0.8,
            color: Style.primary.shade600,
          );

  static TextStyle labelStyle(context) => GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: Style.primary.shade800,
      );

  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.roboto(
        fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.roboto(
        fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.roboto(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.roboto(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.roboto(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static const Color primaryColor = Color(0xff1db7af);

  static const MaterialColor primary = MaterialColor(
    4278265681,
    <int, Color>{
      50: Color(0xffddf2f2),
      100: Color(0xffabe0dd),
      200: Color(0xff70ccc7),
      300: Color(0xff1db7af),
      400: Color(0xff00a79d),
      500: Color(0xff00978b),
      600: Color(0xff008a7d),
      700: Color(0xff007a6d),
      800: Color(0xff006a5d),
      900: Color(0xff004e40),
    },
  );
}

class CompleteBackground extends StatelessWidget {
  const CompleteBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Color(0xffffffff),
              Style.white,
              Colors.white,
              Style.background,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )

          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Colors.white30,
          //     // Colors.white60,
          //     Style.nearlyGray,
          //     Style.primaryEnd.withOpacity(0.016),
          //     Style.primaryEnd.withOpacity(0.032),
          //     // Style.primaryEnd.withOpacity(0.064),
          //   ],
          // ),
          ),
    );
  }
}
