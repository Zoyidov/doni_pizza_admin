class TTimeHelpers {
  static DateTime timestampToDateTime(int unixTimestamp) {
    return DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000).add(const Duration(hours: 10));
  }

  static int dateTimeToTimestamp(DateTime timestamp) {
    final utcDateTime = timestamp.toUtc();
    final timestampInSeconds = utcDateTime.millisecondsSinceEpoch ~/ 1000;
    return timestampInSeconds;
  }

  static String dateTimeToString(DateTime timestamp) {
    // timestamp.add(const Duration(hours: 5));
    final formattedDate =
        '${timestamp.day.toString().padLeft(2, '0')}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    return formattedDate;
  }
}
