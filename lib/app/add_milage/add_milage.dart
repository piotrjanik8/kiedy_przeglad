import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiedy_przeglad/auth/user_profile.dart';

class AddMileagePage extends StatelessWidget {
  AddMileagePage({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj nowy przebieg'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '170 000',
                  label: Text('Wpisz nowy przebieg'),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {

                  Navigator.of(context).pop();
                },
                child: const Text('Zapisz'))
          ],
        ),
      ),
    );
  }
}
