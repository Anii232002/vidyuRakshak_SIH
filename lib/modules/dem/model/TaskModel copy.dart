class Task {
  final double lat;
  final double lon;
  final int priority;
  final String placeName;
  final int isNew;

  Task(
      {required this.lat,
      required this.lon,
      required this.priority,
      required this.placeName,
      required this.isNew});
}
