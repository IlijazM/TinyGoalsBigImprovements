DateTime getStartOfDay() {
  DateTime now = timeNow();
  return DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);
}

DateTime getStartOfWeek() {
  DateTime now = timeNow();
  return DateTime(now.year, now.month, now.day - getWeekday(), 0, 0, 0, 0, 0);
}

DateTime getStartOfMonth() {
  DateTime now = timeNow();
  return DateTime(now.year, now.month, 0, 0, 0, 0, 0, 0);
}

DateTime getStartOfYear() {
  DateTime now = timeNow();
  return DateTime(now.year, 0, 0, 0, 0, 0, 0, 0);
}

DateTime getRemainingTimeOfDay() {
  return DateTime(0, 0, 0, 24 - timeNow().hour);
}

DateTime getRemainingTimeOfMonth() {
  return DateTime(0, 0, 30, 24 - timeNow().hour);
}

int getWeekday() => (timeNow().weekday + 6) % 7;

DateTime Function()? dateTimeNowMock;

DateTime timeNow() =>
    dateTimeNowMock == null ? DateTime.now() : dateTimeNowMock!();
