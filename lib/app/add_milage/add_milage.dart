import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiedy_przeglad/app/add_milage/cubit/add_milage_cubit.dart';
import 'package:kiedy_przeglad/auth/user_profile.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';

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
      body: BlocProvider(
        create: (context) => AddMilageCubit(ServicesRepository()),
        child: BlocBuilder<AddMilageCubit, AddMilageState>(
          builder: (context, state) {
            return Center(
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
                        context.read<ServicesRepository>().enterCurrentMileage(
                            newCurrentMileage: controller.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Zapisz'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
