import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/constants/cont.dart';
import 'package:fyp_emergency_services_pannel/constants/router.dart';
import 'package:fyp_emergency_services_pannel/models/enum.dart';
import 'package:fyp_emergency_services_pannel/services/local_db.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';

import 'sidebar_bottom_section.dart';
import 'sidebar_menu.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String user = GetStorage().read(LocalDB.userRole);
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 70,
                  child: Image.asset(appLogo, fit: BoxFit.cover),
                ),

                Text(
                  "Crash Guard",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: user == UserRole.admin.name
                  ? <Widget>[
                      const SidebarMenuItem(
                        title: 'Today\'s Accidents',
                        icon: HugeIcons.strokeRoundedHospital01,
                        route: RouterService.accidentRoute,
                      ),
                      const SidebarMenuItem(
                        title: 'Reported Accidents',
                        icon: HugeIcons.strokeRoundedHospital01,
                        route: RouterService.submittedReportedRoute,
                      ),
                      const SidebarMenuItem(
                        title: 'Accidents Logs',
                        icon: HugeIcons.strokeRoundedCalendar01,
                        route: RouterService.accidentsLogsRoute,
                      ),
                      const SidebarMenuItem(
                        title: 'Users',
                        icon: HugeIcons.strokeRoundedGroup01,
                        route: RouterService.usersRoute,
                      ),
                    ]
                  : user == UserRole.police.name
                  ? [
                      const SidebarMenuItem(
                        title: 'Today\'s Accidents',
                        icon: HugeIcons.strokeRoundedHospital01,
                        route: RouterService.accidentRoute,
                      ),
                      const SidebarMenuItem(
                        title: 'Reported Accidents',
                        icon: HugeIcons.strokeRoundedHospital01,
                        route: RouterService.submittedReportedRoute,
                      ),
                      const SidebarMenuItem(
                        title: 'Accidents Logs',
                        icon: HugeIcons.strokeRoundedCalendar01,
                        route: RouterService.accidentsLogsRoute,
                      ),
                    ]
                  : [
                      const SidebarMenuItem(
                        title: 'Today\'s Accidents',
                        icon: HugeIcons.strokeRoundedHospital01,
                        route: RouterService.accidentRoute,
                      ),
                      const SidebarMenuItem(
                        title: 'Reported Accidents',
                        icon: HugeIcons.strokeRoundedHospital01,
                        route: RouterService.submittedReportedRoute,
                      ),
                    ],
            ),
          ),
          const SidebarBottomSection(),
        ],
      ),
    );
  }
}
