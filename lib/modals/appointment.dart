import 'dart:convert';

enum AppointmentStatus {
  Created,
  Accepted,
  Finished,
  Pending, // Payments that are pending...
  Rejected, // Rejected the appointment
  Cancelled, //Cancelled the appointment
  Rescheduled,
  Done, // Payment is done and everything is completed
  // PaymentPending,
}

String appointmentStatusToString(AppointmentStatus status) {
  switch (status) {
    case AppointmentStatus.Created:
      return 'Created';
    case AppointmentStatus.Pending:
      return 'Pending';
    case AppointmentStatus.Rejected:
      return 'Rejected';
    case AppointmentStatus.Accepted:
      return 'Accepted';
    case AppointmentStatus.Cancelled:
      return 'Cancelled';
    case AppointmentStatus.Finished:
      return 'Finished';
    case AppointmentStatus.Rescheduled:
      return 'Rescheduled';
    case AppointmentStatus.Done:
      return 'Done';
  }
}

AppointmentStatus appointmentStatusFromString(String status) {
  switch (status) {
    case 'Created':
      return AppointmentStatus.Created;
    case 'Pending':
      return AppointmentStatus.Pending;
    case 'Rejected':
      return AppointmentStatus.Rejected;
    case 'Accepted':
      return AppointmentStatus.Accepted;
    case 'Cancelled':
      return AppointmentStatus.Cancelled;
    case 'Finished':
      return AppointmentStatus.Finished;
    case 'Rescheduled':
      return AppointmentStatus.Rescheduled;
    case 'Done':
      return AppointmentStatus.Done;
  }
  return AppointmentStatus.Pending;
}

String dateToString(DateTime date) => date.toString().split(' ')[0];
DateTime stringToDate(String date) => DateTime.parse(date);

List<Appointment> toAppointmentList(Map<String, dynamic> snapshot) =>
    snapshot.entries.map((e) => Appointment.fromMap(snapshot)).toList();

List<Map> fromAppointmentList(List<Appointment> appointmentList) =>
    appointmentList.map((e) => e.toMap()).toList();

class Appointment {
  String? appointmentID;
  DateTime? plannedDateTime;
  DateTime? actualDateTime;
  String? doctorID;
  String? patientID;
  AppointmentStatus? status;
  String? reason;
  double? fees;
  String? description;
  Appointment({
    this.appointmentID,
    this.plannedDateTime,
    this.actualDateTime,
    this.doctorID,
    this.patientID,
    this.reason,
    this.fees,
    this.description,
    this.status = AppointmentStatus.Created,
  });

  Appointment copyWith({
    String? appointmentID,
    DateTime? plannedDateTime,
    DateTime? actualDateTime,
    String? doctorID,
    String? patientID,
    String? reason,
    double? fees,
    String? description,
    AppointmentStatus? status,
  }) {
    return Appointment(
      appointmentID: appointmentID ?? this.appointmentID,
      plannedDateTime: plannedDateTime ?? this.plannedDateTime,
      actualDateTime: actualDateTime ?? this.actualDateTime,
      doctorID: doctorID ?? this.doctorID,
      patientID: patientID ?? this.patientID,
      reason: reason ?? this.reason,
      fees: fees ?? this.fees,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appointmentID': appointmentID,
      'plannedDateTime': plannedDateTime?.millisecondsSinceEpoch,
      'actualDateTime': actualDateTime?.millisecondsSinceEpoch,
      'doctorID': doctorID,
      'patientID': patientID,
      'reason': reason,
      'fees': fees,
      'description': description,
      'status': appointmentStatusToString(status!),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      appointmentID: map['appointmentID'],
      plannedDateTime: map['plannedDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['plannedDateTime'])
          : null,
      actualDateTime: map['actualDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['actualDateTime'])
          : null,
      doctorID: map['doctorID'],
      patientID: map['patientID'],
      reason: map['reason'],
      fees: map['fees']?.toDouble(),
      description: map['description'],
      status: appointmentStatusFromString(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Appointment(appointmentID: $appointmentID, plannedDateTime: $plannedDateTime, actualDateTime: $actualDateTime, doctorID: $doctorID, patientID: $patientID, reason: $reason, fees: $fees, description: $description, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appointment &&
        other.appointmentID == appointmentID &&
        other.plannedDateTime == plannedDateTime &&
        other.actualDateTime == actualDateTime &&
        other.doctorID == doctorID &&
        other.patientID == patientID &&
        other.reason == reason &&
        other.fees == fees &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode {
    return appointmentID.hashCode ^
        plannedDateTime.hashCode ^
        actualDateTime.hashCode ^
        doctorID.hashCode ^
        patientID.hashCode ^
        reason.hashCode ^
        status.hashCode ^
        fees.hashCode ^
        description.hashCode;
  }
}

class PatientAppointment {
  DateTime? date;
  String? doctorID;
  String? appointmentID;

  PatientAppointment({
    this.date,
    this.doctorID,
    this.appointmentID,
  });

  PatientAppointment copyWith({
    DateTime? date,
    String? doctorID,
    String? appointmentID,
  }) {
    return PatientAppointment(
      date: date ?? this.date,
      doctorID: doctorID ?? this.doctorID,
      appointmentID: appointmentID ?? this.appointmentID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date?.millisecondsSinceEpoch,
      'doctorID': doctorID,
      'appointmentID': appointmentID,
    };
  }

  factory PatientAppointment.fromMap(Map<String, dynamic> map) {
    return PatientAppointment(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      doctorID: map['doctorID'],
      appointmentID: map['appointmentID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientAppointment.fromJson(String source) =>
      PatientAppointment.fromMap(json.decode(source));

  @override
  String toString() =>
      'PatientAppointment(date: $date, doctorID: $doctorID, appointmentID: $appointmentID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatientAppointment &&
        other.date == date &&
        other.doctorID == doctorID &&
        other.appointmentID == appointmentID;
  }

  @override
  int get hashCode =>
      date.hashCode ^ doctorID.hashCode ^ appointmentID.hashCode;
}
