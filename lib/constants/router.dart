import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/services/local_db.dart';
import 'package:fyp_emergency_services_pannel/views/pages/accident/accident.dart';
import 'package:fyp_emergency_services_pannel/views/pages/accident_logs/accident_logs.dart';
import 'package:fyp_emergency_services_pannel/views/pages/login/login.dart';
import 'package:fyp_emergency_services_pannel/views/pages/main_layout/main_layout.dart';
import 'package:fyp_emergency_services_pannel/views/pages/submitted_reported/submitted_reported.dart';
import 'package:fyp_emergency_services_pannel/views/pages/users/users.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  RouterService._();
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static BuildContext get context => key.currentState!.context;

  static const loginRoute = '/login';
  static const accidentRoute = '/dashboard';
  static const accidentsLogsRoute = '/accidentsLogs';
  static const usersRoute = '/users';
  static const submittedReportedRoute = '/submittedReported';
  static final GoRouter router = GoRouter(
    initialLocation: accidentRoute,
    navigatorKey: key,

    // refreshListenable: authProvider,
    redirect: (context, state) async {
      final user = await GetStorage().read(LocalDB.userId);
      if (user == null) {
        return loginRoute;
      }
      return null;
    },
    routes: [
      GoRoute(path: loginRoute, builder: (context, state) => LoginPage()),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: accidentRoute,
            builder: (context, state) => AccidentPage(),
          ),
          GoRoute(
            path: accidentsLogsRoute,
            builder: (context, state) => AccidentLogsPage(),
          ),
          GoRoute(path: usersRoute, builder: (context, state) => UserPage()),
          GoRoute(
            path: submittedReportedRoute,
            builder: (context, state) => SubmittedReportedPage(),
          ),
        ],
      ),
    ],
  );
}
