import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      emit(
        ServicesState(
          documents: data.docs,
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
