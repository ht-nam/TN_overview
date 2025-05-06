import 'package:flutter/material.dart';

class DistrictDetailPopup extends StatelessWidget {
  final String districtName;

  const DistrictDetailPopup({super.key, required this.districtName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(districtName),
      content: Text('Details about $districtName.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
