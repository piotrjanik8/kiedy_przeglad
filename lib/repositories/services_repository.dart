import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiedy_przeglad/models/service_model.dart';

class ServicesRepository {
  final userID = FirebaseAuth.instance.currentUser?.uid;

  Stream<List<ServiceModel>> getServicesStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('dk47EUIsFuZtjjcdWSBB0tVdfRz1')
        .collection('services')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ServiceModel(
            id: doc.id,
            date: (doc['date'] as Timestamp).toDate(),
            mileage: doc['mileage'],
            name: doc['name'],
          );
        },
      ).toList();
    });
  }
}
