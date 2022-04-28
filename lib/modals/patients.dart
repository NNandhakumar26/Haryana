import 'dart:convert';

import 'package:doctor_booking_application/modals/person.dart';

class Patient {
  String? patientId;
  Person? person;
  Address? address;
  String? reason;
  Patient({
    this.patientId,
    this.person,
    this.address,
    this.reason,
  });

  Patient copyWith({
    String? patientId,
    Person? person,
    Address? address,
    String? reason,
  }) {
    return Patient(
      patientId: patientId ?? this.patientId,
      person: person ?? this.person,
      address: address ?? this.address,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'person': person?.toMap(),
      'address': address?.toMap(),
      'reason': reason,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patientId: map['patientId'],
      person: map['person'] != null ? Person.fromMap(map['person']) : null,
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      reason: map['reason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient(patientId: $patientId, person: $person, address: $address, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.patientId == patientId &&
        other.person == person &&
        other.address == address &&
        other.reason == reason;
  }

  @override
  int get hashCode {
    return patientId.hashCode ^
        person.hashCode ^
        address.hashCode ^
        reason.hashCode;
  }
}
