import 'package:flutter/material.dart';

class AddService extends StatelessWidget {
  const AddService({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Center(
          child: Text('dodawanie'),
        ),
      ],
    );
  }
}