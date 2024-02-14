import 'package:flutter/material.dart';
import 'package:flutter_web_getx_deep_link/common/widgets/side_menu.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Row(
        children: [
          SideMenu(),
          Expanded(
            child: Center(
              child: Text('Dashboard Screen'),
            ),
          ),
        ],
      ),
    );
  }
}