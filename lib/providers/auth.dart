import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/router.dart';
import 'package:fyp_emergency_services_pannel/services/local_db.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  Future<void> logOut() async {
    GetStorage().remove(LocalDB.userId);
    GetStorage().remove(LocalDB.userRole);
    RouterService.context.go(RouterService.loginRoute);
    notifyListeners();
  }

  Future<void> saveFcmToken() async {
    try {
      await requestPermissionWeb();
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      final userId = await GetStorage().read(LocalDB.userId);
      if (fcmToken != null && userId != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).update(
          {'fcmToken': fcmToken},
        );

        dev.log('✅ FCM token saved successfully: $fcmToken');
      } else {
        dev.log('⚠️ FCM token is null');
      }
    } catch (e) {
      dev.log('❌ Error saving FCM token: $e');
    }
    // showLanguageDialog(context);
  }

  Future<void> requestPermissionWeb() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);

    print("Permission status: ${settings.authorizationStatus}");
  }
}
