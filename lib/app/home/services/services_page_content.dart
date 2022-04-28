import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiedy_przeglad/app/home/services/cubit/services_cubit.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';

class Services extends StatelessWidget {
  const Services({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesCubit(ServicesRepository())..start(),
      child: BlocBuilder<ServicesCubit, ServicesState>(
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
                if (serviceModel.finished)
                  const SizedBox.shrink()
                else
                  Dismissible(
                    key: ValueKey(serviceModel.id),
                    background: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Icon(
                            Icons.check_box,
                          ),
                        ),
                      ),
                    ),
                    secondaryBackground: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 25.0),
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      context
                          .read<ServicesRepository>()
                          .delete(id: serviceModel.id);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      color: const Color.fromARGB(139, 0, 208, 255),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Pozostało ${serviceModel.daysLeft()} dni lub ${serviceModel.mileageLeft()} km', //dodać metodę z intl do wyśwl pozostałego czasu i przebiegu
                              style: GoogleFonts.lato(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            serviceModel.name,
                            style: GoogleFonts.lato(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                serviceModel.date.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 126, 126, 126),
                                ),
                              ),
                              Text(
                                'Przebieg: ' +
                                    serviceModel.mileage.toString() +
                                    ' km',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 91, 87, 87),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
