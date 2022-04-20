import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiedy_przeglad/models/service_model.dart';
import 'package:meta/meta.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit()
      : super(
          const ServicesState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const ServicesState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('dk47EUIsFuZtjjcdWSBB0tVdfRz1') //zamienić na userID
        .collection('services')
        .snapshots()
        .listen((data) {
      final serviceModels = data.docs.map(
        (doc) {
          return ServiceModel(
            date: (doc['date'] as Timestamp).toDate(),
            mileage: doc['mileage'],
            name: doc['name'],
          );
        },
      ).toList();
      emit(
        ServicesState(
          documents: serviceModels,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          ServicesState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
