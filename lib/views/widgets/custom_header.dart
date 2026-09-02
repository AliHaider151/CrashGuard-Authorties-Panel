import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/constants/extensions.dart';
import 'package:fyp_emergency_services_pannel/constants/response.dart';
import 'package:fyp_emergency_services_pannel/models/accident.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/providers/auth.dart';
import 'package:fyp_emergency_services_pannel/services/local_db.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/confirm_dialoge.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_button.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/icon_button.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/no_data.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class CustomHeader extends StatelessWidget {
  final bool showSearch;
  final String? hintText;
  final ValueChanged<String>? onSearchChanged;

  const CustomHeader({
    super.key,
    this.showSearch = true,
    this.hintText,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final userRole = GetStorage().read(LocalDB.userRole);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            20.width,
            ResponsiveHandling.isDesktop(context)
                ? SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, color: AppColors.darkGrey),
                  ),
            // ResponsiveHandling.isDesktop(context)
            //     ? SizedBox.shrink()
            //     : 20.width,
            // showSearch
            //     ? CustomTextField(
            //         label: hintText ?? 'Search',
            //         controller: TextEditingController(),
            //         suffixIcon: Icon(
            //           FluentIcons.search_12_regular,
            //           size: 16,
            //           color: Colors.grey,
            //         ),
            //         radius: 10,
            //         width: ResponsiveHandling.isMobile(context)
            //             ? MediaQuery.of(context).size.width / 4
            //             : 300,
            //       )
            //     : SizedBox.shrink(),
            // showSearch ? const Spacer() : SizedBox.shrink(),
            // Icon(FluentIcons.alert_24_regular),
            NotificationIcon(),
            20.width,
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 22,
              child: Icon(FluentIcons.person_12_regular, color: Colors.white),
            ),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userRole,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Pannel",
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            20.width,
            CustomButton(
              width: 120,
              label: "Sign Out",
              borderColor: Colors.grey.shade300,
              color: Colors.white,
              textColor: Colors.black,
              icon: HugeIcons.strokeRoundedLogout01,
              onTap: () {
                showConfirmationDialoge(
                  confimrBtnTitle: "Log Out",
                  title: "Sign Out",
                  subTitle: "Are you sure you want to sign out?",
                  onConfirm: () => context.read<AuthProvider>().logOut(),
                );
              },
            ),
            20.width,
          ],
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<AccidentProvider>(
      builder: (context, provider, _) {
        final notificationCount = provider.pendingAccidets.length;
        return PopupMenuButton(
          tooltip: 'Notification',
          offset: const Offset(0, 12),
          elevation: 8,

          constraints: BoxConstraints(minWidth: 200.0, maxWidth: 500.0),

          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(FluentIcons.alert_24_regular, size: 26),
              if (notificationCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),

          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: false,

              padding: EdgeInsets.zero,
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications.",
                            style: textTheme.headlineSmall,
                          ),

                          CustomIconButton(
                            icons: Icons.close,
                            onTap: () => Navigator.of(context).pop(),
                            activeColor: Colors.grey.shade200,
                            iconColor: Colors.black,
                            iconActiveColor: Colors.red,
                            borderColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),

                    provider.pendingAccidets.isEmpty
                        ? NoDataWidget(message: "No Notifications Found.")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.pendingAccidets.length,
                            itemBuilder: (context, index) =>
                                AccidentNotificationTile(
                                  accident: provider.pendingAccidets[index],
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                          ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AccidentNotificationTile extends StatelessWidget {
  final AccidentModel accident;
  final VoidCallback? onTap;

  const AccidentNotificationTile({
    super.key,
    required this.accident,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(Icons.car_crash, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Accident detected",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13, // 🔑 smaller
                            // color: AppColors.primary,
                          ),
                        ),
                      ),
                      Text(
                        accident.timestamp?.timePassed() ?? "",
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // Description (sentence-like)
                  Text(
                    "Location: ${accident.address}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
