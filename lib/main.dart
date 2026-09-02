import 'dart:developer' as dev;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fyp_emergency_services_pannel/constants/router.dart';
import 'package:fyp_emergency_services_pannel/constants/theme.dart';
import 'package:fyp_emergency_services_pannel/firebase_options.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/providers/auth.dart';
import 'package:fyp_emergency_services_pannel/providers/login.dart';
import 'package:fyp_emergency_services_pannel/providers/user.dart';
import 'package:fyp_emergency_services_pannel/services/web_notification.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    dev.log('Got notification: ${message.notification?.title}');
    dev.log('Message body: ${message.notification?.body}');
    showWebNotification(message);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AccidentProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
        title: 'fyp_emergency_services_pannel',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: RouterService.router,
      ),
    );
  }
}
