DateTime getStartOfDay() {
  DateTime now = DateTime.now();
  var res = DateTime(
    now.year,
    now.month,
    now.day,
    0,
    0,
    0,
    0,
    0,
  );
  print(res);
  return res;
}

DateTime getStartOfMonth() {
  DateTime now = DateTime.now();
  return DateTime(
    now.year,
    now.month,
    0,
    0,
    0,
    0,
    0,
    0,
  );
}

DateTime getStartOfYear() {
  DateTime now = DateTime.now();
  return DateTime(
    now.year,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
}
