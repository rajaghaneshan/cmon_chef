import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/features/network/GetX/network_controller.dart';
import 'package:cmon_chef/features/network/presentation/offline_screen.dart';
import 'package:cmon_chef/features/profile/presentation/profile_screen.dart';
import 'package:cmon_chef/features/search/presentation/search_screen.dart';
import 'package:cmon_chef/features/wishlist/presentation/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/home/presentation/pages/home_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NetworkController _networkController = Get.find<NetworkController>();
  @override
  void initState() {
    homeController.selectedIndex.value = 0;
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
                    HomePage(),
                    SearchScreen(),
                    WishlistScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
              bottomNavigationBar: Obx(
                () => BottomNavigationBar(
                  currentIndex: homeController.selectedIndex.value,
                  onTap: homeController.onTap,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.white,
                  selectedItemColor: AppColors.primary,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.restaurant_menu,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                        ),
                        label: 'Search'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite_outline,
                        ),
                        label: 'Wishlist'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.account_circle_outlined,
                        ),
                        label: 'Me')
                  ],
                ),
              ),
            );
    });
  }
}
