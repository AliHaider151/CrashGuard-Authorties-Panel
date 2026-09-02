import 'package:intl/intl.dart';

class DateTimeService {
  static String formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return "";

    String date = DateFormat("dd/MM/yyyy").format(timestamp);
    String time = DateFormat("hh:mm a").format(timestamp);

    return "$date, $time";
  }
}
