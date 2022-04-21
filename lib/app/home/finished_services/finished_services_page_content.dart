import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiedy_przeglad/app/home/finished_services/cubit/finished_services_cubit.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';

class FinishedServices extends StatelessWidget {
  const FinishedServices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinishedServicesCubit(ServicesRepository())..start(),
      child: BlocBuilder<FinishedServicesCubit, FinishedServicesState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                'Something went wrong: ${state.errorMessage}',
              ),
            );
          }

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final serviceModels = state.documents;

          return ListView(
            children: [
              for (final serviceModel in serviceModels) ...[
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  color: const Color.fromARGB(255, 9, 255, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Za ' +
                              '0' +
                              ' dni'), //metoda obliczająca dni do przeglądu
                          const Text('lub'),
                          Text('za ' +
                              serviceModel.mileage.toString() +
                              ' km'), //metoda obliczająca pozostały przebieg
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          serviceModel.name,
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(serviceModel.date.toString()),
                          //dodać metodę z intl do wyśwl tylko daty
                          Text('Przebieg: ' +
                              serviceModel.mileage.toString() +
                              ' km'),
                        ],
                      ),
                      Text(serviceModel.date.toString()),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}