import 'package:flutter/material.dart';

class SortingDialogue extends StatefulWidget {
  const SortingDialogue({super.key});

  @override
  State<SortingDialogue> createState() => _SortingDialogueState();
}

class _SortingDialogueState extends State<SortingDialogue> {
  @override
  Widget build(BuildContext context) {
    String selectedOption = 'All';
    return AlertDialog(
      title: const Text('Sort'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile<String>(
            title: const Text('All'),
            value: 'All',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<String>(
            title: const Text('Age: Elder'),
            value: 'Elder',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<String>(
            title: const Text('Age: Younger'),
            value: 'Younger',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
