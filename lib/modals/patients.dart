import 'address.dart';
import 'appointment.dart';
import 'guardian.dart';

class Patient {
  String? patientId;
  String? name;
  int? age;
  String? patientPhoneNo;
  String? patientEmail;
  int? months;
  String? gender;
  DateTime? birthDate;
  Guardian? guardian;
  Address? patientAddress;
  String? relationWithGuardian;
  String? reason;
  List<Appointments>? appointments;
}