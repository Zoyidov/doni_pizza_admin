class TTimeHelpers {
  static DateTime timestampToDateTime(int unixTimestamp) {
    final millisecondsSinceEpoch = unixTimestamp * 1000;
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: true);
  }

  static int dateTimeToTimestamp(DateTime timestamp) {
    final utcDateTime = timestamp.toUtc();
    final timestampInSeconds = utcDateTime.millisecondsSinceEpoch ~/ 1000;
    return timestampInSeconds;
  }


  static String dateTimeToString(DateTime timestamp) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (isSameDay(timestamp, now)) {
      return 'Bugun ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (isSameDay(timestamp, yesterday)) {
      return 'Kecha ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      final formattedDate =
          '${timestamp.day.toString().padLeft(2, '0')}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
      return formattedDate;
    }
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }


}
