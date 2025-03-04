import 'package:intl/intl.dart';

String formatVyajDate(String date) {
  try {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    int day = parsedDate.day;

    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }
    return "$day$suffix";
  } catch (e) {
    return date;
  }
}
