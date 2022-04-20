import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddService extends StatelessWidget {
  const AddService({
    Key? key,
    required this.onTitleChanged,
    required this.onMileageChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged ;
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
            onChanged: onTitleChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Wymiana filtra powietrza',
              label: Text('Nazwa serwisu'),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: onMileageChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '90 000',
              label: Text('Przebieg'),
            ),
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
            Navigator.of(context).pop;
            },
            child: Text(selectedDateFormatted ?? 'Wymierz termin'),
          ),
          TextButton(
              onPressed: () {
                //  FirebaseFirestore.instance
                //    .collection('users').doc(userID).collection('services').add(
                //      {
                //        'name': ,
                //        'milleage' ,
                //        'name' ,
                //      }
                //    );
              },
              child: const Text('Zapisz nowy serwis'))
        ],
        );
  }
}
