import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/pages/accident/components/accident_tile.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_page.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_textfield.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/loading_widget.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/multiple_datepicker.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/no_data.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AccidentLogsPage extends StatefulWidget {
  const AccidentLogsPage({super.key});

  @override
  State<AccidentLogsPage> createState() => _AccidentLogsPageState();
}

class _AccidentLogsPageState extends State<AccidentLogsPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await context.read<AccidentProvider>().updateDateRange(
        DateTime.now().subtract(Duration(days: 1)),
        DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccidentProvider>(
      builder: (context, provider, _) => CustomPageWidget(
        title: "Accident Logs",
        subTitle: "View all accident logs",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 230,
                child: CustomTextField(
                  controller: TextEditingController(
                    text: provider.startDate != null && provider.endDate != null
                        ? "${provider.startDate!.month}/${provider.startDate!.day}/${provider.startDate!.year}"
                              " - "
                              "${provider.endDate!.month}/${provider.endDate!.day}/${provider.endDate!.year}"
                        : "",
                  ),
                  label: "Date Range",
                  readOnly: true,
                  ontap: () async {
                    showDialog(
                      context: context,
                      builder: (_) => MultipleDatePickerDialog(
                        onDateSelected: (dates) async {
                          if (dates.isNotEmpty) {
                            context.pop();

                            final start = DateTime.parse(dates.first);
                            final end = DateTime.parse(dates.last);
                            await provider.updateDateRange(start, end);
                          } else {
                            context.pop();

                            await provider.updateDateRange(null, null);
                          }
                        },
                      ),
                    );
                  },
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            20.height,
            Consumer<AccidentProvider>(
              builder: (context, provider, _) => provider.isLoading
                  ? LoadingWidget()
                  : provider.rangeAccidents.isEmpty
                  ? NoDataWidget(message: "No Accident Logs Found.")
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 20,
                      runSpacing: 30,
                      children: [
                        ...List.generate(
                          provider.rangeAccidents.length,
                          (index) => AccidentTile(
                            accident: provider.rangeAccidents[index],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
