import 'package:cmon_chef/core/app_constants.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset(
        googleSignInButton,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }
}
