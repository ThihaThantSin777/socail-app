import 'package:flutter/material.dart';

extension NavigatorView on Widget {
  void navigatePushReplacement(BuildContext context, Widget nextScreen) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => nextScreen));
  }

  void navigatePush(BuildContext context, Widget nextScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => nextScreen));
  }

   showSnackBarWithMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
