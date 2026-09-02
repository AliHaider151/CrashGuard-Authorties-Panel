import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/router.dart';
import 'package:fyp_emergency_services_pannel/models/user.dart';
import 'package:fyp_emergency_services_pannel/repository/auth.dart';
import 'package:fyp_emergency_services_pannel/services/local_db.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/snack_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class LoginProvider extends ChangeNotifier {
  final emailCont = TextEditingController(text: 'demo@gmail.com');
  final passCont = TextEditingController(text: 'Demo@123');
  // final roleCont = TextEditingController(text: UserRole.emergencyServices.name);

  bool isRememberMe = false;

  bool loginLoading = false;

  Future<void> login(BuildContext context) async {
    dev.log("Login");
    if (validator()) {
      try {
        dev.log("Login");
        loginLoading = true;
        notifyListeners();
        final user = await AuthRepository().login(
          emailCont.text,
          passCont.text,
        );
        if (user != null) {
          dev.log(user.toJson().toString());
          saveUser(user);
          context.go(RouterService.accidentRoute);
          dev.log("Login successful");
        }
      } catch (e) {
        showSnackbar(true, e.toString());
        dev.log(e.toString());
      } finally {
        loginLoading = false;
        notifyListeners();
      }
    }
  }

  validator() {
    if (emailCont.text.isEmpty) {
      showSnackbar(true, "Enter the email");
      return false;
    } else if (passCont.text.isEmpty) {
      showSnackbar(true, "Enter the password");
      return false;
    }
    return true;
  }

  void saveUser(UserModel user) {
    GetStorage().write(LocalDB.userId, user.email);
    GetStorage().write(LocalDB.userRole, user.role.toString());
  }

  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
    notifyListeners();
  }
}
