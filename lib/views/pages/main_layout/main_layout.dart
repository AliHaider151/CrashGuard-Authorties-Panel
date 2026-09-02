import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/response.dart';
import 'package:fyp_emergency_services_pannel/views/pages/main_layout/components/side_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveHandling.isDesktop(context)
              ? const SidebarWidget()
              : SizedBox.shrink(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
