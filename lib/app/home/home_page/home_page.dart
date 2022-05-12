import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiedy_przeglad/app/add_milage/add_milage.dart';
import 'package:kiedy_przeglad/app/home/add_service/add_service_page_content.dart';
import 'package:kiedy_przeglad/app/home/finished_services/finished_services_page_content.dart';
import 'package:kiedy_przeglad/app/home/home_page/cubit/home_page_cubit.dart';
import 'package:kiedy_przeglad/app/home/services/services_page_content.dart';
import 'package:kiedy_przeglad/auth/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocProvider(
          create: (context) => HomePageCubit()..getMileage(),
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return Text(state.errorMessage); //error.toString()
              }
              if (state.isLoading) {
                return const Text('Loading');
              }

              final documents = state.documents;
              return Text('Aktualny przebieg: ${documents[0]['mileage']} km');
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddMileagePage(),
              fullscreenDialog: true,
            ),
          );
        },
        tooltip: 'Wpisz aktualny przebieg',
        label: const Text('Dodaj aktualny przebieg'),
        icon: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (context) {
          if (currentIndex == 0) {
            return const Services();
          }
          if (currentIndex == 1) {
            return const AddService();
          }
          return const FinishedServices();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Najbliższy serwis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj nowy serwis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Historia napraw',
          ),
        ],
      ),
    );
  }
}
