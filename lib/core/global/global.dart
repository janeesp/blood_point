import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var primaryColor = const Color(0xff601AB9);
void showUploadMessage(BuildContext context, String message, Color color,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: showLoading
            ? const Duration(minutes: 30)
            : const Duration(seconds: 3),
        backgroundColor: Colors.green,
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: CircularProgressIndicator(),
              ),
            Text(
              message,
              style: TextStyle(fontSize: 15, color: color),
            ),
          ],
        ),
      ),
    );
}

void showErorMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: showLoading
            ? const Duration(minutes: 30)
            : const Duration(seconds: 4),
        backgroundColor:Colors.red,
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: CircularProgressIndicator(),
              ),
            Text(
              message,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
}


Future<bool> alert(
BuildContext context,
String message,
) async  {
  bool result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0)),
        title: const Text('Are you sure ?'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: const Text('No',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: const Text('Yes',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          )
        ],
      ));
  return result;
}