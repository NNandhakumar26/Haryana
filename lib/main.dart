import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/hospital_registration.dart';
import 'package:doctor_booking_application/first_page/first_page.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

import 'Registration/registration_main.dart';

void main() async {
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //Added Everything
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      showPerformanceOverlay: false,
      theme: ThemeData(
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
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      ),
      // home: DoctorRegistrationPage(
      //   doctor: Doctor(),
      // ),
      home: RegistrationMainPage(),
      // home: FirstPage(),
      // home: HospitalformWidget(hospital: Hospital()),
    );
  }
}
