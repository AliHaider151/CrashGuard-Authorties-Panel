import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class MultipleDatePickerDialog extends StatelessWidget {
  final Function(List<String>) onDateSelected;
  MultipleDatePickerDialog({super.key, required this.onDateSelected});

  List<String> dateTimes = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: size.height * 0.7,
          width: size.width * 0.5,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Column(
            children: [
              SfDateRangePicker(
                backgroundColor: Colors.white,
                onSelectionChanged: _onSelectionChanged,
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(),
                  backgroundColor: Colors.white,
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: size.height * 0.016,
                  ),
                  todayTextStyle: TextStyle(
                    fontSize: size.height * 0.016,
                    color: AppColors.primary,
                  ),
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                  textStyle: TextStyle(fontSize: size.height * 0.016),
                ),
                selectionTextStyle: TextStyle(fontSize: size.height * 0.016),
                selectionColor: AppColors.primary.withOpacity(0.2),
                rangeSelectionColor: AppColors.primary.withOpacity(0.2),
                endRangeSelectionColor: AppColors.primary,
                startRangeSelectionColor: AppColors.primary,
                todayHighlightColor: AppColors.primary,
                toggleDaySelection: true,
                rangeTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: size.height * 0.016,
                ),
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                  DateTime.now(),
                  DateTime.now(),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text('Cancel', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (dateTimes.isNotEmpty) {
                        // Return the selected dates through the callback
                        onDateSelected(dateTimes);
                      } else {
                        // Handle empty date selection if needed
                      }
                    },
                    child: Text('Done'),
                  ),
                  SizedBox(width: size.width * 0.01),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final value = args.value as PickerDateRange;

      if (value.startDate != null && value.endDate != null) {
        dateTimes = generateDateRange(value.startDate!, value.endDate!);
      }
    }
  }

  List<String> generateDateRange(DateTime startDate, DateTime endDate) {
    List<String> dateRange = [];

    if (endDate.isBefore(startDate)) {
      final temp = startDate;
      startDate = endDate;
      endDate = temp;
    }

    for (
      DateTime currentDate = startDate;
      currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate);
      currentDate = currentDate.add(Duration(days: 1))
    ) {
      dateRange.add(currentDate.toString().split(' ')[0]);
    }

    return dateRange;
  }
}
