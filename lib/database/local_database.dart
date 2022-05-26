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

  // get and put teh appointment id
  static Appointment? get getAppointmentId {
    // use a try catch block here
    List? val = box!.get('appointmentId', defaultValue: null);
    if (val == null) {
      return null;
    } else {
      return Appointment(
          appointmentID: val[0], doctorID: val[1], actualDateTime: val[2]);
    }
  }

  static Future<void> setAppointmentId(Appointment? appointment) async {
    if (appointment != null)
      await box!.put('appointmentId', [
        appointment.appointmentID,
        appointment.doctorID,
        appointment.actualDateTime
      ]);
    else
      await box!.put('appointmentId', null);
  }
}
