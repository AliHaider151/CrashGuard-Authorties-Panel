import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/router.dart';
import 'package:fyp_emergency_services_pannel/models/user.dart';
import 'package:fyp_emergency_services_pannel/repository/auth.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/snack_bar.dart';
import 'package:go_router/go_router.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    Future.delayed(Duration.zero, () async {
      await getUsers();
    });
  }

  bool isLoading = false;

  final nameCont = TextEditingController();
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final roleCont = TextEditingController();

  final users = <UserModel>[];

  Future<void> getUsers() async {
    try {
      isLoading = true;
      notifyListeners();
      final temp = await AuthRepository().getUsers();
      users
        ..clear()
        ..addAll(temp);
      notifyListeners();
    } catch (e) {
      showSnackbar(true, e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser() async {
    if (validator()) {
      try {
        isLoading = true;
        notifyListeners();
        await AuthRepository().register(
          nameCont.text,
          emailCont.text.toLowerCase(),
          passCont.text,
          roleCont.text,
        );
        showSnackbar(false, "User added successfully");
        RouterService.context.pop();
        await getUsers();
      } catch (e) {
        showSnackbar(true, e.toString());
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> updateUser() async {
    if (validator()) {
      final user = UserModel(
        name: nameCont.text,
        email: emailCont.text.toLowerCase(),
        password: passCont.text,
        role: roleCont.text,
      );
      try {
        isLoading = true;
        notifyListeners();
        await AuthRepository().updateUser(user);
        showSnackbar(false, "User updated successfully");
        RouterService.context.pop();
        await getUsers();
      } catch (e) {
        showSnackbar(true, e.toString());
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  updateRole(String value) {
    roleCont.text = value;
    notifyListeners();
  }

  clear() {
    nameCont.clear();
    emailCont.clear();
    passCont.clear();
    roleCont.clear();

    notifyListeners();
  }

  intilizeValue(UserModel user) {
    nameCont.text = user.name;
    emailCont.text = user.email;
    passCont.text = user.password;
    roleCont.text = user.role;
    notifyListeners();
  }

  validator() {
    if (nameCont.text.isEmpty) {
      showSnackbar(true, "Enter the name");
      return false;
    }
    if (emailCont.text.isEmpty) {
      showSnackbar(true, "Enter the email");
      return false;
    }
    if (passCont.text.isEmpty) {
      showSnackbar(true, "Enter the password");
      return false;
    }

    return true;
  }
}
