class FormatHelper {
  static String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    String period = hour >= 12 ? 'م' : 'ص';

    hour = hour % 12;
    if (hour == 0) hour = 12;

    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$hour:$formattedMinute $period';
  }
}
