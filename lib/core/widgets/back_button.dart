import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: 40,
        width: 40,
        margin:const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(left: 3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:const  Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
    );
  }
}
