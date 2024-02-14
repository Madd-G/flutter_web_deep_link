import 'package:flutter/material.dart';
import 'package:flutter_web_getx_deep_link/common/routes/routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.INITIAL,
      defaultTransition: Transition.noTransition,
      getPages: AppPages.routes,
      navigatorObservers: [RouteObservers()],
    );
  }
}

class MyAppController extends GetxController {
  RxInt currentTabIndex = 0.obs;

  void changeTabIndex(int index) {
    currentTabIndex.value = index;
  }
}

final MyAppController myAppController = Get.put(MyAppController());

class RouteObservers extends GetObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    String currentPage = Get.currentRoute;
    if (currentPage == '/') {
      myAppController.changeTabIndex(0);
    } else if (currentPage.contains(AppRoutes.SETTINGS)) {
      AppPages.childRoutes.forEach((parentRoute, childRoutes) {
        if (currentPage.contains(parentRoute)) {
          myAppController.changeTabIndex(1);
          return;
        }
      });
    } else if (currentPage == AppRoutes.PROFILE) {
      myAppController.changeTabIndex(2);
    }
    AppPages.history.add(currentPage);
  }
}
