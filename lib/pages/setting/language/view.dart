import 'package:flutter/material.dart';
import 'package:flutter_web_getx_deep_link/common/widgets/side_menu.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        leading: const SizedBox.shrink(),
      ),
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const Text('Language Screen'),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Back to Settings'),
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
