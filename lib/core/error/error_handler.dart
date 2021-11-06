import 'package:flutter/material.dart';

import 'failures.dart';

class ErrorHandler
{
  static handleError(BuildContext context,Failure failure)
  {
    switch (failure.runtimeType) {
      case TokenExpiredFailure:
        showSnackBar(context,'SERVER_FAILURE_MESSAGE');
        break;
      case ServerFailure:
        showSnackBar(context,'SERVER_FAILURE_MESSAGE');
        break;
      default:
        showSnackBar(context,'UNEXPECTED_ERROR');
        break;
    }
  }
}

void showSnackBar(BuildContext context,String message) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      textAlign: TextAlign.left,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
