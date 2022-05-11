import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:doctor_booking_application/modals/appointment.dart';
import 'package:doctor_booking_application/modals/person.dart';
import 'package:doctor_booking_application/modals/slot.dart';

class Doctor {
  String? doctorID;
  Person? person;
  List<String>? specializations;
  String? Qualification;
  String? Experience;

  // String? doctorSignature;
  double? doctorFees;
  int? doctorTiming;
  String? hospitalName;
  String? hospitalId;

  List<Appointment>? appointments;
  int? checkupDuration;

  Doctor({
    // this.doctorSignature,
    this.doctorID,
    this.person,
    this.specializations,
    this.Qualification,
    this.Experience,
    this.doctorFees,
    this.doctorTiming,
    this.hospitalName,
    this.hospitalId,
    this.appointments,
    this.checkupDuration,
  });

  Doctor copyWith({
    String? doctorID,
    Person? person,
    List<String>? specializations,
    String? Qualification,
    String? Experience,
    double? doctorFees,
    int? doctorTiming,
    String? hospitalName,
    String? hospitalId,
    List<Appointment>? appointments,
    int? checkupDuration,
  }) {
    return Doctor(
      doctorID: doctorID ?? this.doctorID,
      person: person ?? this.person,
      specializations: specializations ?? this.specializations,
      Qualification: Qualification ?? this.Qualification,
      Experience: Experience ?? this.Experience,
      doctorFees: doctorFees ?? this.doctorFees,
      doctorTiming: doctorTiming ?? this.doctorTiming,
      hospitalName: hospitalName ?? this.hospitalName,
      hospitalId: hospitalId ?? this.hospitalId,
      appointments: appointments ?? this.appointments,
      checkupDuration: checkupDuration ?? this.checkupDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorID': doctorID,
      'person': person?.toMap(),
      'specializations': specializations,
      'Qualification': Qualification,
      'Experience': Experience,
      'doctorFees': doctorFees,
      'doctorTiming': doctorTiming,
      'hospitalName': hospitalName,
      'hospitalId': hospitalId,
      'appointments': appointments?.map((x) => x?.toMap())?.toList(),
      'checkupDuration': checkupDuration,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      doctorID: map['doctorID'],
      person: map['person'] != null ? Person.fromMap(map['person']) : null,
      specializations: List<String>.from(map['specializations']),
      Qualification: map['Qualification'],
      Experience: map['Experience'],
      doctorFees: map['doctorFees']?.toDouble(),
      doctorTiming: map['doctorTiming']?.toInt(),
      hospitalName: map['hospitalName'],
      hospitalId: map['hospitalId'],
      appointments: map['appointments'] != null
          ? List<Appointment>.from(
              map['appointments']?.map((x) => Appointment.fromMap(x)))
          : null,
      checkupDuration: map['checkupDuration']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Doctor(doctorID: $doctorID, person: $person, specializations: $specializations, Qualification: $Qualification, Experience: $Experience, doctorFees: $doctorFees, doctorTiming: $doctorTiming, hospitalName: $hospitalName, hospitalId: $hospitalId, appointments: $appointments, checkupDuration: $checkupDuration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Doctor &&
        other.doctorID == doctorID &&
        other.person == person &&
        listEquals(other.specializations, specializations) &&
        other.Qualification == Qualification &&
        other.Experience == Experience &&
        other.doctorFees == doctorFees &&
        other.doctorTiming == doctorTiming &&
        other.hospitalName == hospitalName &&
        other.hospitalId == hospitalId &&
        listEquals(other.appointments, appointments) &&
        other.checkupDuration == checkupDuration;
  }

  @override
  int get hashCode {
    return doctorID.hashCode ^
        person.hashCode ^
        specializations.hashCode ^
        Qualification.hashCode ^
        Experience.hashCode ^
        doctorFees.hashCode ^
        doctorTiming.hashCode ^
        hospitalName.hashCode ^
        hospitalId.hashCode ^
        appointments.hashCode ^
        checkupDuration.hashCode;
  }
}
