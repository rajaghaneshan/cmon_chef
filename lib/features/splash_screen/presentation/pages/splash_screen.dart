import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/features/splash_screen/presentation/widgets/google_sign_in_button.dart';
import 'package:cmon_chef/features/splash_screen/presentation/widgets/splash_screen_logo.dart';
import 'package:cmon_chef/features/dashboard/presentation/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
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
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController);

    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
          ),
        ),
      );
      // print('Error signing in: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      // print('Error signing in: $err');
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
              builder: (context) => const Home(),
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
    googleSignIn.signIn().catchError((err) {
      if (err is PlatformException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              err.code.toString(),
            ),
          ),
        );
      }
    });
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
              SplashScreenLogo(size: size),
              Positioned(
                bottom: size.height * 0.1,
                child: InkWell(
                  onTap: () {
                    login();
                  },
                  child: const GoogleSignInButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
