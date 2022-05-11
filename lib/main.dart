import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/hospital_registration.dart';
import 'package:doctor_booking_application/database/local_database.dart';
import 'package:doctor_booking_application/first_page/first_page.dart';
import 'package:doctor_booking_application/main_page.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Registration/registration_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Local.initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      theme: Style.themeData(context),

      // home: RegistrationMainPage(),

      home: MainPage(
        doctorLogin: false,
      ),
      // home: FirstPage(),
      // home: HospitalRegistrationWidget(hospital: Hospital()),
    );
  }
}
