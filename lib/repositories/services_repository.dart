import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiedy_przeglad/models/service_model.dart';

class ServicesRepository {
  final userID = FirebaseAuth.instance.currentUser?.uid;

  Stream<List<ServiceModel>> getServicesStream() {
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
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

  Future<void> add(
    String name,
    int mileage,
    DateTime date,
  ) async {
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('services')
        .add(
      {
        'name': name,
        'mileage': mileage,
        'date': date,
      },
    );
  }
}
