import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kiedy_przeglad/models/service_model.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';
import 'package:meta/meta.dart';

part 'finished_services_state.dart';

class FinishedServicesCubit extends Cubit<FinishedServicesState> {
  FinishedServicesCubit(this._servicesRepository)
      : super(
          const FinishedServicesState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final ServicesRepository _servicesRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const FinishedServicesState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription =
        _servicesRepository.getServicesStream().listen((data) {
      emit(
        FinishedServicesState(
          documents: data,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              FinishedServicesState(
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
