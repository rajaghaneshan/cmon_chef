import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title:const  Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary,
                  backgroundImage: NetworkImage(
                      '${homeController.currentUser.value!.photoUrl}'),
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  padding:const  EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${homeController.currentUser.value!.displayName}'),
                      Text(homeController.currentUser.value!.email),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: TextButton(
              onPressed: () {
                googleSignIn.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:const  [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  Text(
                    ' Log out',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
