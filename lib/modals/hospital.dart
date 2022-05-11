import 'dart:convert';

import 'package:doctor_booking_application/modals/person.dart';

class Hospital {
  String? hospitalID;
  String? hospitalName;
  Address? hospitalAddress;
  int? primaryContact;
  int? secondaryContact;
  String? hospitalEmail;
  String? hospitalType;
  Hospital({
    this.hospitalID,
    this.hospitalName,
    this.hospitalAddress,
    this.primaryContact,
    this.secondaryContact,
    this.hospitalEmail,
    this.hospitalType,
  });

  Hospital copyWith({
    String? hospitalID,
    String? hospitalName,
    Address? hospitalAddress,
    int? primaryContact,
    int? secondaryContact,
    String? hospitalEmail,
    String? hospitalType,
  }) {
    return Hospital(
      hospitalID: hospitalID ?? this.hospitalID,
      hospitalName: hospitalName ?? this.hospitalName,
      hospitalAddress: hospitalAddress ?? this.hospitalAddress,
      primaryContact: primaryContact ?? this.primaryContact,
      secondaryContact: secondaryContact ?? this.secondaryContact,
      hospitalEmail: hospitalEmail ?? this.hospitalEmail,
      hospitalType: hospitalType ?? this.hospitalType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hospitalID': hospitalID,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress?.toMap(),
      'primaryContact': primaryContact,
      'secondaryContact': secondaryContact,
      'hospitalEmail': hospitalEmail,
      'hospitalType': hospitalType,
    };
  }

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      hospitalID: map['hospitalID'],
      hospitalName: map['hospitalName'],
      hospitalAddress: map['hospitalAddress'] != null
          ? Address.fromMap(map['hospitalAddress'])
          : null,
      primaryContact: map['primaryContact']?.toInt(),
      secondaryContact: map['secondaryContact']?.toInt(),
      hospitalEmail: map['hospitalEmail'],
      hospitalType: map['hospitalType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hospital.fromJson(String source) =>
      Hospital.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hospital(hospitalID: $hospitalID, hospitalName: $hospitalName, hospitalAddress: $hospitalAddress, primaryContact: $primaryContact, secondaryContact: $secondaryContact, hospitalEmail: $hospitalEmail, hospitalType: $hospitalType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hospital &&
        other.hospitalID == hospitalID &&
        other.hospitalName == hospitalName &&
        other.hospitalAddress == hospitalAddress &&
        other.primaryContact == primaryContact &&
        other.secondaryContact == secondaryContact &&
        other.hospitalEmail == hospitalEmail &&
        other.hospitalType == hospitalType;
  }

  @override
  int get hashCode {
    return hospitalID.hashCode ^
        hospitalName.hashCode ^
        hospitalAddress.hashCode ^
        primaryContact.hashCode ^
        secondaryContact.hashCode ^
        hospitalEmail.hashCode ^
        hospitalType.hashCode;
  }
}
