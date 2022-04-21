import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiedy_przeglad/app/home/add_service/cubit/add_cubit.dart';
import 'package:kiedy_przeglad/app/home/home_page.dart';
import 'package:kiedy_przeglad/repositories/services_repository.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String? name;
  int? mileage;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ServicesRepository()),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return _AddPageBody(
              onNameChanged: (newValue) {
                setState(() {
                  name = newValue;
                });
              },
              onMileageChanged: (newValue) {
                setState(() {
                  mileage = int.parse(newValue);
                });
              },
              onDateChanged: (newValue) {
                setState(() {
                  date = newValue;
                });
              },
              selectedDateFormatted:
                  date == null ? null : DateFormat.yMMMMEEEEd().format(date!),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody({
    Key? key,
    required this.onNameChanged,
    required this.onMileageChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onNameChanged;
  final Function(String) onMileageChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      children: [
        TextField(
          onChanged: onNameChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Wymiana oleju',
            label: Text('Nazwa serwisu'),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          onChanged: onMileageChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '170 000',
            label: Text('Przebieg'),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 365 * 10),
              ),
            );
            onDateChanged(selectedDate);
          },
          child: Text(selectedDateFormatted ?? 'Wybierz datę'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          },
          child: const Text('Zapisz'),
        ),
      ],
    );
  }
}
