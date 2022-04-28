import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:doctor_booking_application/modals/person.dart';
import 'package:doctor_booking_application/modals/slot.dart';

class Doctor {
  String? doctorID;
  Person? person;
  List<String>? specializations;
  String? doctorQualification;
  String? doctorExperience;
  Address? doctorAddress;

  // String? doctorSignature;
  double? doctorFees;
  int? doctorTiming;
  String? doctorHospital;
  List<Slot>? slots;
  int? checkupDuration;

  Doctor({
    // this.doctorSignature,
    this.doctorID,
    this.person,
    this.specializations,
    this.doctorQualification,
    this.doctorExperience,
    this.doctorAddress,
    this.doctorFees,
    this.doctorTiming,
    this.doctorHospital,
    this.slots,
    this.checkupDuration,
  });

  Doctor copyWith({
    String? doctorID,
    Person? person,
    List<String>? specializations,
    String? doctorQualification,
    String? doctorExperience,
    Address? doctorAddress,
    double? doctorFees,
    int? doctorTiming,
    String? doctorHospital,
    List<Slot>? slots,
    int? checkupDuration,
  }) {
    return Doctor(
      doctorID: doctorID ?? this.doctorID,
      person: person ?? this.person,
      specializations: specializations ?? this.specializations,
      doctorQualification: doctorQualification ?? this.doctorQualification,
      doctorExperience: doctorExperience ?? this.doctorExperience,
      doctorAddress: doctorAddress ?? this.doctorAddress,
      doctorFees: doctorFees ?? this.doctorFees,
      doctorTiming: doctorTiming ?? this.doctorTiming,
      doctorHospital: doctorHospital ?? this.doctorHospital,
      slots: slots ?? this.slots,
      checkupDuration: checkupDuration ?? this.checkupDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorID': doctorID,
      'person': person?.toMap(),
      'specializations': specializations,
      'doctorQualification': doctorQualification,
      'doctorExperience': doctorExperience,
      'doctorAddress': doctorAddress?.toMap(),
      'doctorFees': doctorFees,
      'doctorTiming': doctorTiming,
      'doctorHospital': doctorHospital,
      'slots': slots?.map((x) => x?.toMap())?.toList(),
      'checkupDuration': checkupDuration,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      doctorID: map['doctorID'],
      person: map['person'] != null ? Person.fromMap(map['person']) : null,
      specializations: List<String>.from(map['specializations']),
      doctorQualification: map['doctorQualification'],
      doctorExperience: map['doctorExperience'],
      doctorAddress: map['doctorAddress'] != null
          ? Address.fromMap(map['doctorAddress'])
          : null,
      doctorFees: map['doctorFees']?.toDouble(),
      doctorTiming: map['doctorTiming']?.toInt(),
      doctorHospital: map['doctorHospital'],
      slots: map['slots'] != null
          ? List<Slot>.from(map['slots']?.map((x) => Slot.fromMap(x)))
          : null,
      checkupDuration: map['checkupDuration']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Doctor(doctorID: $doctorID, person: $person, specializations: $specializations, doctorQualification: $doctorQualification, doctorExperience: $doctorExperience, doctorAddress: $doctorAddress, doctorFees: $doctorFees, doctorTiming: $doctorTiming, doctorHospital: $doctorHospital, slots: $slots, checkupDuration: $checkupDuration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Doctor &&
        other.doctorID == doctorID &&
        other.person == person &&
        listEquals(other.specializations, specializations) &&
        other.doctorQualification == doctorQualification &&
        other.doctorExperience == doctorExperience &&
        other.doctorAddress == doctorAddress &&
        other.doctorFees == doctorFees &&
        other.doctorTiming == doctorTiming &&
        other.doctorHospital == doctorHospital &&
        listEquals(other.slots, slots) &&
        other.checkupDuration == checkupDuration;
  }

  @override
  int get hashCode {
    return doctorID.hashCode ^
        person.hashCode ^
        specializations.hashCode ^
        doctorQualification.hashCode ^
        doctorExperience.hashCode ^
        doctorAddress.hashCode ^
        doctorFees.hashCode ^
        doctorTiming.hashCode ^
        doctorHospital.hashCode ^
        slots.hashCode ^
        checkupDuration.hashCode;
  }
}
