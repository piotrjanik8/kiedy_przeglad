part of 'services_cubit.dart';

@immutable
class ServicesState {
  final List<ServiceModel> documents;
  final bool isLoading;
  final String errorMessage;

  const ServicesState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
