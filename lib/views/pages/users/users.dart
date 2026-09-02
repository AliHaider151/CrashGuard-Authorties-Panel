import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/constants/decoration.dart';
import 'package:fyp_emergency_services_pannel/models/user.dart';
import 'package:fyp_emergency_services_pannel/providers/user.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/pages/users/components/add_user.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_button.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_page.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/status_tile.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomPageWidget(
      title: "Users",
      subTitle: "Manage users and their information",
      child: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: ContainerDecoration.greyBorder,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(FluentIcons.people_24_regular),
                        5.width,
                        Text(
                          'User Management',
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Staff Users',
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomButton(
                          width: 140,
                          label: 'Add New User',
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const AddUserDialog(),
                            );
                          },
                          icon: FluentIcons.add_24_regular,
                        ),
                      ],
                    ),
                    20.height,
                    if (provider.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (provider.users.isEmpty)
                      const Center(child: Text("No users found"))
                    else
                      Column(
                        children: provider.users
                            .map(
                              (user) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                child: _userTile(textTheme, user, context),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              // 20.height,
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: CustomButton(
              //     width: 170,
              //     label: "Save All Settings",
              //     onTap: () {
              //       /// yahan agar tumhe kuch global save karna ho to add karo
              //     },
              //     icon: FluentIcons.save_24_regular,
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }

  Widget _userTile(TextTheme textTheme, UserModel user, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: ContainerDecoration.greyBorder.copyWith(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(FluentIcons.person_24_regular, color: Colors.grey),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.name} ",
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                user.email,
                style: textTheme.bodySmall!.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          StatusTile(
            label: user.role,
            color: AppColors.tabbarColor,
            textColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          ),

          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AddUserDialog(user: user),
              );
            },
            child: Text(
              'Edit',
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
