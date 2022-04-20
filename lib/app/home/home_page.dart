import 'package:flutter/material.dart';
import 'package:kiedy_przeglad/app/add_milage/add_milage.dart';
import 'package:kiedy_przeglad/app/home/add_service/add_service_page_content.dart';
import 'package:kiedy_przeglad/app/home/history_services/history_services_page_content.dart';
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
        title: const Text('Aktualny przebieg: 173 000 km'),
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
              builder: (context) => const AddMileagePage(),
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
            // return AddService();
          }
          return const Calendar();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
