import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/features/network/network_binding.dart';
import 'package:cmon_chef/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:cmon_chef/features/dashboard/presentation/getX/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/recipe/data/models/offline_recipe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OfflinerecipeAdapter());
  await Hive.openBox<Offlinerecipe>(recipeBox);
  await Hive.openBox('user');
  await Firebase.initializeApp();
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: NetworkBinding(),
      theme: ThemeData(
        textTheme: const TextTheme(),
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.primary,
      ),
      home: const SplashScreen(),
    );
  }
}
