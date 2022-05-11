import 'dart:convert';

import 'package:doctor_booking_application/modals/person.dart';

class Patient {
  String? patientID;
  Person? person;
  String? reason;
  Patient({
    this.patientID,
    this.person,
    this.reason,
  });

  Patient copyWith({
    String? patientID,
    Person? person,
    String? reason,
  }) {
    return Patient(
      patientID: patientID ?? this.patientID,
      person: person ?? this.person,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientID': patientID,
      'person': person?.toMap(),
      'reason': reason,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patientID: map['patientID'],
      person: map['person'] != null ? Person.fromMap(map['person']) : null,
      reason: map['reason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() =>
      'Patient(patientID: $patientID, person: $person, reason: $reason)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.patientID == patientID &&
        other.person == person &&
        other.reason == reason;
  }

  @override
  int get hashCode => patientID.hashCode ^ person.hashCode ^ reason.hashCode;
}
