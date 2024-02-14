import 'package:flutter/material.dart';
import 'package:flutter_web_getx_deep_link/common/routes/routes.dart';
import 'package:flutter_web_getx_deep_link/common/widgets/side_menu.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const Text('Settings Screen'),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.LANGUAGE);
                    },
                    child: const Text('Go to Language'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
