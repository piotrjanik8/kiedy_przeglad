import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(
          const HomePageState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> getMileage() async {
    emit(
      const HomePageState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('dk47EUIsFuZtjjcdWSBB0tVdfRz1')
        .collection('current_mileage')
        .snapshots()
        .listen(
      (data) {
        emit(
          HomePageState(
            documents: data.docs,
            errorMessage: '',
            isLoading: false,
          ),
        );
      },
    )..onError((error) {
        emit(
          HomePageState(
            documents: const [],
            errorMessage: error.toString(),
            isLoading: false,
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
