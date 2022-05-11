import 'package:bloc/bloc.dart';
import 'package:kiedy_przeglad/models/service_model.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._servicesRepository)
      : super(HomePageState());

  final ServicesRepository _servicesRepository;

  Future<void> getCurrentMileage() async {
    final currentMileage = await _servicesRepository.getMilleage();
    emit(HomePageState(currentMileage: currentMileage));
  }
}

// class HomePageCubit extends Cubit<HomePageState> {          //do usunięcia jak kod wyżej uruchomię
//   HomePageCubit()
//       : super(HomePageState());
// }
