import 'package:flutter/material.dart';

showErrorMessage({required BuildContext context,required String errorMessage}){
     showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('İşlem başarısız.'),
          content:  Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam...'),
            ),
          ],
        ),
      );
  }

