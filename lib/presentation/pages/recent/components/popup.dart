import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Function onDeleteConfirmed;

  ConfirmDeleteDialog({required this.onDeleteConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete this item?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            onDeleteConfirmed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
