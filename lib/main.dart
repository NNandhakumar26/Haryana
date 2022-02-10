import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Style.primary,
        primaryColor: Style.primaryColor,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF57636C),
                fontSize: 14,
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
          contentPadding: EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
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
                EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
          ),
        ),
        //Text button for primary colour
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

        textTheme: Style.textTheme,
        scaffoldBackgroundColor: Colors.white,
        //TODO: Read the documentation
        typography: Typography.material2018(),
      ),
      home: DoctorRegistrationPage(
        doctor: Doctor(),
      ),
    );
  }
}
