import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/features/dashboard/presentation/widgets/bottom_nav_bar.dart';
import 'package:cmon_chef/features/network/presentation/GetX/network_controller.dart';
import 'package:cmon_chef/features/network/presentation/pages/offline_screen.dart';
import 'package:cmon_chef/features/profile/presentation/profile_screen.dart';
import 'package:cmon_chef/features/search/presentation/pages/search_screen.dart';
import 'package:cmon_chef/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/presentation/pages/home_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NetworkController _networkController = Get.find<NetworkController>();
  @override
  void initState() {
    // homeController.selectedIndex.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkController>(builder: (context) {
      return _networkController.connectionType == 0
          ? OfflineScreen()
          : Scaffold(
              body: SafeArea(
                child: PageView(
                  controller: homeController.pageController,
                  onPageChanged: homeController.onPageChanged,
                  children: [
                    Container(),
                    // HomePage(),
                    SearchScreen(),
                    WishlistScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavBar(),
            );
    });
  }
}
