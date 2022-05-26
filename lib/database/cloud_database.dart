//patient queue
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modals/model_export.dart';

class Network {
  static String tempDoctorId = 'BsPyUjOuwmuc2NRYPNbC';
  static final instance = FirebaseFirestore.instance;
  static final adminInstance = instance.collection('Admin');
  static final hospitalInstance = instance.collection('Hospitals');
  static final doctorInstance = instance.collection('Doctors');
  static final patientInstance = instance.collection('Patients');
  // static final doctorInstance = mainInstance.collection('Doctors');
  // static final patientInstance = mainInstance.collection('Patients');

  static Future<List<String>> getAllSpecializations() async =>
      await adminInstance.doc('Specializations').get().then(
            (mapValue) => (mapValue.data()!['Specializations'] as List<dynamic>)
                .map((e) => e as String)
                .toList(),
          );

  // create a new hospital
  static Future<String> createHospital(Hospital hospital) async {
    return await hospitalInstance
        .add(
      hospital.toMap(),
    )
        .then(
      (value) {
        hospitalInstance.doc(value.id).update(
          {
            'hospitalID': value.id,
          },
        );
        return value.id;
      },
    );
  }

  // get all the hospitals
  static Future<List<Hospital>> getAllHospitals() async {
    return await hospitalInstance.get().then(
      (value) {
        return value.docs
            .map(
              (e) => Hospital.fromMap(
                e.data(),
              ),
            )
            .toList();
      },
    );
  }

  // create a new doctor
  static Future<String> createDoctor(Doctor doctor) async {
    return await doctorInstance
        .add(
      doctor.toMap(),
    )
        .then(
      (value) {
        doctorInstance.doc(value.id).update(
          {
            'doctorID': value.id,
          },
        );
        return value.id;
      },
    );
  }

  // get all the doctors
  static Future<List<Doctor>> getAllDoctors() async {
    return await doctorInstance.get().then(
      (value) {
        return value.docs
            .map(
              (e) => Doctor.fromMap(
                e.data(),
              ),
            )
            .toList();
      },
    );
  }

  // get doctor with ID
  static Future<Doctor> getDoctor(String id) async {
    return await doctorInstance.doc(id).get().then(
          (value) => Doctor.fromMap(
            value.data()!,
          ),
        );
  }

// get doctor with specialization

  static Future<List<Doctor>> getDoctorsWithSpecialization(
      String specialization) async {
    return await doctorInstance
        .where('specializations', arrayContains: specialization)
        .get()
        .then(
      (value) {
        return value.docs
            .map(
              (e) => Doctor.fromMap(
                e.data(),
              ),
            )
            .toList();
      },
    );
  }

  //Create a doctor appointment
  static Future<Appointment?> createAppointment(
    Appointment appointment,
    DateTime date,
  ) async {
    return await doctorInstance
        .doc(appointment.doctorID)
        .collection('Appointments')
        .doc(dateToString(date))
        .set(
      {
        'appointments': FieldValue.arrayUnion([appointment.toMap()]),
      },
      SetOptions(
        merge: true,
      ),
    ).then((value) {
      return appointment;
    });
  }

//Appointment

  static Stream<List<Appointment>> getPatientAppointmentStream({
    required Appointment appointment,
  }) async* {
    if (appointment.doctorID != null) {
      yield* doctorInstance
          .doc(appointment.doctorID)
          .collection('Appointments')
          .doc(
            dateToString(appointment.actualDateTime!),
          )
          .snapshots()
          .map(
            (value) => (value.data()!['appointments'] as List<dynamic>)
                .map(
                  (e) => Appointment.fromMap(e),
                )
                .toList(),
          );
    }
    // } else {
    //   yield* clinicInstance
    //       .collection('Current Appointment')
    //       .where('doctorID', isEqualTo: doctorID)
    //       // .where('status',
    //       //     isEqualTo:
    //       //         AppointmenttatusToString(Appointmenttatus.Rescheduled))
    //       // .where('status',
    //       //     isNotEqualTo:
    //       //         AppointmenttatusToString(Appointmenttatus.Finished))
    //       // .where('status',
    //       //     isNotEqualTo:
    //       //         AppointmenttatusToString(Appointmenttatus.Rescheduled))
    //       // .where('status',
    //       //     isNotEqualTo:
    //       //         AppointmenttatusToString(Appointmenttatus.Rejected))
    //       // .where('status',
    //       //     isNotEqualTo:
    //       //         AppointmenttatusToString(Appointmenttatus.Pending))
    //       .snapshots()
    //       .map(
    //         (event) => event.docs
    //             .map(
    //               (e) => Appointment.fromMap(e.data()),
    //             )
    //             .toList(),
    //       );
    // }
  }

  static Stream<List<Appointment>> getAppointmentStream(
      {String? doctorID, DateTime? dateTime}) async* {
    if (doctorID == null) {
      yield* doctorInstance
          .doc(tempDoctorId)
          .collection('Appointments')
          .doc(dateToString(dateTime!))
          .snapshots()
          .map(
            (value) => (value.data()!['appointments'] as List<dynamic>)
                .map(
                  (e) => Appointment.fromMap(e),
                )
                .toList(),
          );
    }
  }

  // function to update the appointment status
  static Future<bool> updateAppointmentStatus(
      Appointment appointment, AppointmentStatus status) async {
    Appointment thisAppointment = appointment.copyWith(
      staus: status,
    );

    return await doctorInstance
        .doc(appointment.doctorID)
        .collection('Appointments')
        .doc(dateToString(appointment.actualDateTime!))
        .update(
      {
        'appointments': FieldValue.arrayUnion([thisAppointment.toMap()]),
      },
    ).then(
      (value) async {
        await doctorInstance
            .doc(appointment.doctorID)
            .collection('Appointments')
            .doc(dateToString(appointment.actualDateTime!))
            .update(
          {
            'appointments': FieldValue.arrayRemove([appointment.toMap()]),
          },
        );
        return true;
      },
    );
  }

  // get doctor Appointment for consecutive 3 days
  // static Stream<List<Appointment>> getDoctorAppointment(
  //     String id, DateTime dateTime) async* {
  //   // yield the streams of

  //   var temp = doctorInstance
  //       .doc(id)
  //       .collection('Appointment')
  //       .doc(dateToString(dateTime))
  //       .snapshots()
  //       .listen(
  //     (event) {
  //       // return the list of Appointment
  //       if (event.data() != null) {
  //         (event.data()!['Appointment'] as List<dynamic>)
  //             .map((e) => Appointment.fromMap(e))
  //             .toList();
  //       }
  //     },
  //   );
  //   temp.resume();
  //   yield temp;
  //   //     .map(
  //   //   (event) {
  //   //     print(event.data());
  //   //     return (event.data()!['Appointment'] as List<dynamic>).map(
  //   //       (e) {
  //   //         print('Entered into appointment with a value of $e');
  //   //         return Appointment.fromMap(e);
  //   //       },
  //   //     ).toList();
  //   //   },
  //   // );
  // }

  //     .then(
  //   (value) {
  //     try {
  //       if (value.data() == null) throw Exception('No Appointment found');
  //       return toAppointmentList(value.data()!);
  //     } catch (e) {
  //       return [];
  //     }
  //   },
  // );
// create a patient
  static Future<String> createPatient(Patient patient) async {
    return await patientInstance
        .add(
      patient.toMap(),
    )
        .then(
      (value) {
        patientInstance.doc(value.id).update(
          {
            'patientID': value.id,
          },
        );
        return value.id;
      },
    );
  }
}
