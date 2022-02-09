class DuroodModel {
  String? contribution;
  String? date;
  String? fullName;
  bool? isOfficial;
  String? time;
  String? username;

  DuroodModel(
      {required this.contribution,
      required this.date,
      required this.fullName,
      required this.isOfficial,
      required this.time,
      required this.username});

  DuroodModel.fromJson(Map<String, dynamic> parsedJSON)
      : contribution = parsedJSON['contribution'],
        date = parsedJSON['date'],
        fullName = parsedJSON['full_name'],
        isOfficial = parsedJSON['is_official'],
        time = parsedJSON['time'],
        username = parsedJSON['username'];
}
