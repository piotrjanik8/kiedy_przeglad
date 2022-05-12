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
        .orderBy('date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ServiceModel(
            id: doc.id,
            date: (doc['date'] as Timestamp).toDate(),
            mileage: doc['mileage'],
            name: doc['name'],
            finished: doc['finished'],
          );
        },
      ).toList();
    });
  }

  Stream<List<CurrentMileage>> getMilleage() {
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('services')
        .orderBy('date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CurrentMileage(
            currentMileage: doc['mileage'],
          );
        },
      ).toList();
    });
  }

  // Future<CurrentMileage> getMilleage() async {
  //   final doc = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userID)
  //       .collection('current_mileage')
  //       .doc()
  //       .collection('mileage')
  //       .doc('2ZORhguqadI36glvHLpM')
  //       .get();

  //   return CurrentMileage(currentMileage: doc['mileage']);
  // }

  Future<void> saveFinished({
    required String id,
    required String name,
    required int mileage,
    required DateTime date,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('services')
        .doc(id)
        .set({
      'name': name,
      'mileage': mileage,
      'date': date,
      'finished': true,
    });
  }

  Future<void> addCurrentMileage({required String newCurrentMileage}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('current_mileage')
        .doc('2ZORhguqadI36glvHLpM')
        .set({'mileage': newCurrentMileage});
  }

  Future<void> delete({
    required String id,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('services')
        .doc(id)
        .delete();
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
        'finished': false,
      },
    );
  }
}
