import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/providers/auth.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/pages/accident/components/accident_tile.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/analytic.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_page.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/no_data.dart';
import 'package:provider/provider.dart';

class AccidentPage extends StatefulWidget {
  const AccidentPage({super.key});

  @override
  State<AccidentPage> createState() => _AccidentPageState();
}

class _AccidentPageState extends State<AccidentPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<AuthProvider>().saveFcmToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageWidget(
      title: "Accident Management",
      subTitle: "Manage accident reports and related information",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AccidentProvider>(
            builder: (context, provider, _) => AnalyticTile(
              label: "Today's Total Accidents",
              icon: FluentIcons.people_28_regular,
              value: provider.todayAccident.length.toString(),
              color: AppColors.primary,
              des1: "Total Accident Reports",
              des2: "",
              textColor: Colors.black,
            ),
          ),

          20.height,

          Consumer<AccidentProvider>(
            builder: (context, provider, _) => provider.pendingAccidets.isEmpty
                ? NoDataWidget(message: "No Accidents Found.")
                : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 20,
                    runSpacing: 30,
                    children: [
                      ...List.generate(
                        provider.pendingAccidets.length,
                        (index) => AccidentTile(
                          accident: provider.pendingAccidets[index],

                          isUpdateAllowed: true,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
