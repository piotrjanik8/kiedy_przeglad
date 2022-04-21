part of 'finished_services_cubit.dart';

@immutable
class FinishedServicesState {
  final List<ServiceModel> documents;
  final bool isLoading;
  final String errorMessage;

  const FinishedServicesState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}

