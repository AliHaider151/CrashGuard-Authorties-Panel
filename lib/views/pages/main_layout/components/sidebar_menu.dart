import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';

import 'package:go_router/go_router.dart';

class SidebarMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const SidebarMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final String location = GoRouterState.of(context).uri.toString();
    final bool isSelected = location == route;

    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          final currentLocation = GoRouterState.of(context).uri.toString();
          if (currentLocation != route) {
            context.go(route);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 45,
              width: 4,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodySmall!.copyWith(
                  color: isSelected ? AppColors.primary : Colors.grey.shade800,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
