import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/features/home/presentation/pages/home_page.dart';
import 'package:cmon_chef/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isAuth = false;
  final usersRef = FirebaseFirestore.instance.collection('users');

  final timestamp = DateTime.now();
  GoogleSignInAccount? currentUser;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    // _animation = CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.easeIn,
    // );
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController);

    Future.delayed(Duration(seconds: 1), () {
      _animationController.forward().then((value) {});
    });
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });

    super.initState();
  }

  handleSignIn(GoogleSignInAccount? account) async {
    if (account != null) {
      homeController.currentUser.value = googleSignIn.currentUser;
      await createUserInFirestore();
      if (mounted) {
        setState(() {
          isAuth = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        });
      }
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    final GoogleSignInAccount? user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.doc(user!.id).get();

    if (!doc.exists) {
      usersRef.doc(user.id).set({
        "id": user.id,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        color: AppColors.primary,
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
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
              Positioned(
                bottom: size.height * 0.1,
                child: InkWell(
                  onTap: () {
                    login();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/google_sign_in.png',
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
