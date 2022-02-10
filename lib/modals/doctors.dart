

import 'address.dart';

class Doctor {
  String? doctorID;
  String? doctorName;
  int? doctorAge;
  String? doctorSpecialization;
  String? doctorQualification;
  String? doctorExperience;
  Address? doctorAddress;
  int? doctorPhoneNo;
  String? doctorEmail;
  // String? doctorSignature;
  double? doctorFees;
  String? doctorGender;
  int? doctorTiming;
  String? doctorHospital;
  Doctor({
    this.doctorID,
    this.doctorName,
    this.doctorAge,
    this.doctorSpecialization,
    this.doctorQualification,
    this.doctorExperience,
    this.doctorAddress,
    this.doctorPhoneNo,
    this.doctorEmail,
    // this.doctorSignature,
    this.doctorFees,
    this.doctorGender,
    this.doctorTiming,
    this.doctorHospital,
  });
}
