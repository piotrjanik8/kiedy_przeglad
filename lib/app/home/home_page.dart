import 'package:flutter/material.dart';
import 'package:kiedy_przeglad/app/home/add/add_service.dart';
import 'package:kiedy_przeglad/app/home/calendar/calendar.dart';
import 'package:kiedy_przeglad/app/home/services/services.dart';
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
      body: Builder(
        builder: (context) {
          if (currentIndex == 0) {
            return const Services();
          }
          if (currentIndex == 1) {
            return const AddService();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Wpisz aktualny przebieg',
        child: const Icon(Icons.add),
      ),
    );
  }
}
