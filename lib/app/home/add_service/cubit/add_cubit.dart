import 'package:bloc/bloc.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._servicesRepository) : super(const AddState());

  final ServicesRepository _servicesRepository;

  Future<void> add(
    String name,
    int mileage,
    DateTime date,
    bool finished,
  ) async {
    try {
      await _servicesRepository.add(name, mileage, date, finished);

      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
