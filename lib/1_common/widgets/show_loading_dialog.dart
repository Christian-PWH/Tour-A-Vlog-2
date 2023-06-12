import 'package:flutter/material.dart';

Future<void> showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 15,
              ),
              Text('Loading...')
            ],
          ),
        ),
      );
    },
  );
}
