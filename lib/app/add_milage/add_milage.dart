import 'package:flutter/material.dart';
import 'package:kiedy_przeglad/auth/user_profile.dart';

class AddMileagePage extends StatelessWidget {
  const AddMileagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wpisz nowy przebieg:'),
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
      body: const Center(
        child: Text('Aktualny przebieg:'),
      ),
    );
  }
}
