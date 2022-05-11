//registration index - int
//isLoggedIn - boolean

import 'package:doctor_booking_application/modals/model_export.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Local {
  static Box? box;
  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    box = await Hive.openBox('mainBox');
  }

  // get the registration index
  static int get getRegistrationIndex =>
      box!.get('registrationIndex', defaultValue: 0);

  static Future<void> setRegistrationIndex(int index) async {
    await box!.put('registrationIndex', index);
  }

  static Future<void> closeDatabase() async {
    await box?.close();
  }

  // get and put the patient as string
  static Future<String> get getMainUser =>
      box!.get('mainPatient', defaultValue: '');

  static Future<void> setMainUser(Patient patient) async {
    await box!.put('mainPatient', patient);
  }
}
