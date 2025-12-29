import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(int millisecondsSinceEpoch) {
    final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat('MMM d, yyyy').format(date);
  }
}

