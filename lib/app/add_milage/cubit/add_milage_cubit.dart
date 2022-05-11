import 'package:bloc/bloc.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';
import 'package:meta/meta.dart';

part 'add_milage_state.dart';

class AddMilageCubit extends Cubit<AddMilageState> {
  AddMilageCubit(this._servicesRepository) : super(AddMilageState());

  final ServicesRepository _servicesRepository;
}
