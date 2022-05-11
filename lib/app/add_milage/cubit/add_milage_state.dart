part of 'add_milage_cubit.dart';

@immutable
class AddMilageState {
  const AddMilageState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}


