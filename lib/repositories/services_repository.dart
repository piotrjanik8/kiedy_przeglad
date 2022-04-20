import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiedy_przeglad/app/home/services/cubit/services_cubit.dart';

class ServicesRepository {
  Stream<List<ServicesState>> getServicesStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('dk47EUIsFuZtjjcdWSBB0tVdfRz1') //zamienić na userID
        .collection('services')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) => null);
    });
  }
}
