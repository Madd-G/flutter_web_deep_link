// ignore_for_file: constant_identifier_names

import 'package:flutter_web_getx_deep_link/pages/auth/login/index.dart';
import 'package:flutter_web_getx_deep_link/pages/dashboard/index.dart';
import 'package:flutter_web_getx_deep_link/pages/profile/index.dart';
import 'package:flutter_web_getx_deep_link/pages/setting/index.dart';
import 'package:flutter_web_getx_deep_link/pages/setting/language/index.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const INITIAL = '/';
  static const SETTINGS = '/settings';
  static const PROFILE = '/profile';
  static const LANGUAGE = '/settings/language';
}

class AppPages {
  static RxList<String> history = <String>[].obs;
  static final routes = [
    // GetPage(
    //   name: AppRoutes.INITIAL,
    //   page: () => const DashboardScreen(),
    //   binding: DashboardBinding(),
    // ),
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
      children: [
        GetPage(
          name: '/language',
          page: () => const LanguageScreen(),
          binding: LanguageBinding(),
        ),
      ]
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];

  static final Map<String, List<String>> childRoutes = {
    AppRoutes.SETTINGS: [AppRoutes.LANGUAGE],
  };
}