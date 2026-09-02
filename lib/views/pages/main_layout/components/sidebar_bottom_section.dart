import 'package:flutter/material.dart';

class SidebarBottomSection extends StatelessWidget {
  const SidebarBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InkWell(
          //   onTap: () {
          //     // showDialog(
          //     //   context: context,
          //     //   builder: (_) => const LogoutConfirmationDialog(),
          //     // );
          //   },
          //   child: const Row(
          //     children: [
          //       Icon(FluentIcons.sign_out_24_regular, color: Colors.red),
          //       SizedBox(width: 8),
          //       Text(
          //         'Logout',
          //         style: TextStyle(
          //           color: Colors.red,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 12),
          const Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
