import 'package:cmon_chef/core/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  late PageController pageController;
  Rx<GoogleSignInAccount?> currentUser = googleSignIn.currentUser.obs;
  Rx<int> selectedIndex = 0.obs;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void onTap(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
