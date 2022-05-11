import 'package:bloc/bloc.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';
import 'package:meta/meta.dart';

part 'add_milage_state.dart';

class AddMilageCubit extends Cubit<AddMilageState> {
  AddMilageCubit(this._servicesRepository) : super(const AddMilageState());

  final ServicesRepository _servicesRepository;

   Future<void> enterCurrentMileage(
    {required String newCurrentMileage}
    
  ) async {
    try {
      await _servicesRepository.addCurrentMileage(newCurrentMileage: newCurrentMileage);

      emit(const AddMilageState(saved: true));
    } catch (error) {
      emit(AddMilageState(errorMessage: error.toString()));
      
    }
  }

}
