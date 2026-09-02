import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/models/enum.dart';
import 'package:fyp_emergency_services_pannel/models/user.dart';
import 'package:fyp_emergency_services_pannel/providers/user.dart';
import 'package:fyp_emergency_services_pannel/services/local_db.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_dilaoge.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_textfield.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/drop_down.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class AddUserDialog extends StatefulWidget {
  final UserModel? user;
  const AddUserDialog({super.key, this.user});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (widget.user != null) {
        context.read<UserProvider>().intilizeValue(widget.user!);
      } else {
        context.read<UserProvider>().clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    final bool isMyAccount =
        widget.user?.email == GetStorage().read(LocalDB.userId);

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return CustomDialogeWidget(
          title: widget.user == null ? 'Add New User' : 'Update User',
          actionBtnLabel: widget.user == null ? 'Add User' : 'Update User',
          onTab: () async {
            if (widget.user == null) {
              await provider.addUser();
            } else {
              await provider.updateUser();
            }
          },
          subtitile: widget.user == null
              ? 'Create a new user account. The user will receive login credentials via email.'
              : 'Update this user account details.',
          isLoading: provider.isLoading,
          child: Column(
            children: [
              CustomTextField(
                label: 'Enter full name',
                controller: provider.nameCont,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Enter email address',
                controller: provider.emailCont,
              ),
              const SizedBox(height: 16),

              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: CustomDropDown(
                      prefix: isMyAccount
                          ? const Icon(FluentIcons.lock_closed_24_regular)
                          : null,
                      selectedLable: isMyAccount
                          ? widget.user?.role
                          : provider.roleCont.text,
                      label: 'Select Role',

                      items: isMyAccount
                          ? []
                          : UserRole.values.map((e) => e.name).toList(),
                      onChanged: (val) {
                        provider.updateRole(val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Enter password',
                controller: provider.passCont,
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
