import 'package:flutter/material.dart';
import 'package:flutter_web_getx_deep_link/main.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView(
        children: <Widget>[
          Obx(() => ListTile(
            title: const Text('Dashboard'),
            tileColor: myAppController.currentTabIndex.value == 0
                ? Colors.grey
                : null,
            onTap: () {
              myAppController.changeTabIndex(0);
              Get.offAllNamed('/');
            },
          )),
          Obx(() => ListTile(
            title: const Text('Settings'),
            tileColor: myAppController.currentTabIndex.value == 1
                ? Colors.grey
                : null,
            onTap: () {
              myAppController.changeTabIndex(1);
              Get.offAllNamed('/settings');
            },
          )),
          Obx(() => ListTile(
            title: const Text('Profile'),
            tileColor: myAppController.currentTabIndex.value == 2
                ? Colors.grey
                : null,
            onTap: () {
              myAppController.changeTabIndex(2);
              Get.offAllNamed('/profile');
            },
          )),
        ],
      ),
    );
  }
}
