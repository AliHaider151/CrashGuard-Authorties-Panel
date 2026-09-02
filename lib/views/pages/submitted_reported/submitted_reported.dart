import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/views/pages/accident/components/accident_tile.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_page.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/no_data.dart';
import 'package:provider/provider.dart';

class SubmittedReportedPage extends StatefulWidget {
  const SubmittedReportedPage({super.key});

  @override
  State<SubmittedReportedPage> createState() => _SubmittedReportedPageState();
}

class _SubmittedReportedPageState extends State<SubmittedReportedPage> {
  @override
  Widget build(BuildContext context) {
    return CustomPageWidget(
      title: "Submitted Reported",
      subTitle: "Manage submitted reported",
      child: Consumer<AccidentProvider>(
        builder: (context, provider, _) => provider.submittedReported.isEmpty
            ? const NoDataWidget(message: "No Submitted Reported Found.")
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 30,
                children: [
                  ...List.generate(
                    provider.submittedReported.length,
                    (index) => AccidentTile(
                      accident: provider.submittedReported[index],

                      onUpdate: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
