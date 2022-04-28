//patient queue
import 'package:cloud_firestore/cloud_firestore.dart';

class Network {
  static String tempDoctorId = 'HOoJ5GDp6lHE7mRlyRqz';
  static final instance = FirebaseFirestore.instance;
  static final clinicInstance = instance.collection('Dexterity').doc('Clinic1');
  static final doctorInstance = clinicInstance.collection('Doctors');
  static final patientInstance = clinicInstance.collection('Patients');
  static final adminInstance = clinicInstance.collection('Admins');

  static Future<List<String>> getAllSpecializations() async =>
      await clinicInstance.get().then(
            (mapValue) =>
                (mapValue.data()!['SpecialistsAvailable'] as List<dynamic>)
                    .map((e) => e as String)
                    .toList(),
          );
}
