import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiedy_przeglad/app/home/services/cubit/services_cubit.dart';

class Services extends StatelessWidget {
  const Services({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return BlocProvider(
      create: (context) => ServicesCubit()..start(),
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
                              serviceModel.mileage +
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
                          Text('Przebieg: ' + serviceModel.mileage + ' km'),
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
