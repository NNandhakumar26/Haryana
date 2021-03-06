import 'package:doctor_booking_application/Components/loading.dart';
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

  static textFieldStyle(context) =>
      Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 16,
            color: Style.darkerText,
            fontWeight: FontWeight.w600,
          );

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

  static InputDecoration customBorderFieldDecoration(context, int hintText) =>
      InputDecoration(
        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Color(0xFF57636C),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
        hintStyle: Style.textTheme.caption!.copyWith(
          color: Colors.black26,
          fontSize: 12,
          letterSpacing: 0.4,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFDBE2E7),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFDBE2E7),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  static InputDecoration get searchFieldStyle => InputDecoration(
        hintText: 'Book An Appointment',
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black12,
        ),
        filled: true,
        fillColor: Style.primary.shade50.withOpacity(0.32),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Style.primary.shade50,
            width: 1.32,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Style.primary.shade50,
            width: 1.32,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
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

  static Future<T?> navigate<T>(BuildContext context, Widget widget) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      PageRouteBuilder<T>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  static Future loadingDialog(BuildContext context,
      {Widget? widget, String? title}) {
    return showDialog(
      context: context,
      builder: (context) => (widget != null)
          ? widget
          : CustomLoadingDialog(
              title: title ?? '',
            ),
    );
  }

  static Future<T?> navigateBack<T>(BuildContext context, Widget widget) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
          // return FadeTransition(
          //   opacity: animation,
          //   child: RotationTransition(
          //     turns:
          //         Tween<double>(begin: 0.5, end: 1.0)
          //             .animate(animation),
          //     child: child,
          //   ),
          // );
        },
      ),
    );
  }

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

  static ThemeData themeData(context) => ThemeData(
        primaryColor: Style.primaryColor,
        textTheme: Style.textTheme,
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          dialTextColor: Colors.black54,
          helpTextStyle: Theme.of(context).textTheme.headline6,
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(Style.primaryColor),
        ),
        radioTheme: RadioThemeData(
          overlayColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          fillColor: MaterialStateProperty.all(Style.primaryColor),
        ),
        iconTheme: IconThemeData(
          size: 18,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
          hintStyle: Style.textTheme.caption!.copyWith(
            color: Colors.black26,
            fontSize: 12,
            letterSpacing: 0.4,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          filled: true,
          fillColor: Colors.white,
          iconColor: Colors.black38,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Theme.of(context).primaryColor,
        ),

        colorScheme: ColorScheme(
          primary: Style.primaryColor,
          secondary: Color(0xff1c2340), //001038
          surface: Color(0xff8a8da0), //868a9a
          background: Colors.white,
          error: Color(0xffFF2021),
          //TODO: Read the documentation and change accordingly
          onPrimary: Style.primaryColor,
          onSecondary: Color(0xff1c2340),
          onSurface: Color(0xff8a8da0),
          onBackground: Colors.white,
          onError: Color(0xffFF2021),
          brightness: Brightness.light,
        ),
        //Outlined button for primary colour
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(StadiumBorder()),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.button!.copyWith(
                    color: Colors.white.withOpacity(0.97),
                  ),
            ),
            backgroundColor: MaterialStateProperty.all(Style.primaryColor),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: 40,
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(StadiumBorder()),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.button!.copyWith(
                    color: Style.primaryColor,
                  ),
            ),
            backgroundColor:
                MaterialStateProperty.all(Colors.white.withOpacity(0.97)),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
          ),
        ),

        scaffoldBackgroundColor: Color.fromARGB(255, 240, 241, 241),
        //TODO: Read the documentation
        typography: Typography.material2018(),
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
