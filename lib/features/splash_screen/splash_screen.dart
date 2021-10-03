import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/features/home/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        color: AppColors.primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'C'),
                    TextSpan(
                      text: '\'',
                      style: TextStyle(
                        color: AppColors.accent,
                      ),
                    ),
                    TextSpan(
                      text: 'mon',
                    ),
                  ],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontFamily: 'ClementePDa',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                'Chef',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
