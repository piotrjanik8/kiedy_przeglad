import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kiedy_przeglad/models/service_model.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';
import 'package:meta/meta.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this._servicesRepository)
      : super(
          const ServicesState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final ServicesRepository _servicesRepository;

  StreamSubscription? _streamSubscription; 

  Future<void> start() async {
    emit(
      const ServicesState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = _servicesRepository.getServicesStream()
        .listen((data) {
      
      emit(
        ServicesState(
          documents: data,
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

  Future<void> remove({required String documentID}) async {
    try {
      await _servicesRepository.delete(id: documentID);
    } catch (error) {
      emit(
        ServicesState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
      );
      start();
    }
  }

Future<void> finished({required String documentID,
    required String name,
    required int mileage,
    required DateTime date,}) async {
    try {
      await _servicesRepository.saveFinished(id: documentID, date: date, mileage: mileage, name: name);
    } catch (error) {
      emit(
        ServicesState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
