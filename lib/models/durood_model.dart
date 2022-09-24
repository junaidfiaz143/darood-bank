class DuroodModel {
  String? contribution;
  String? contributionId;
  String? fullName;
  bool? isOfficial;
  String? timeStamp;
  String? username;

  DuroodModel(
      {required this.contribution,
      required this.contributionId,
      required this.fullName,
      required this.isOfficial,
      required this.timeStamp,
      required this.username});

  DuroodModel.fromJson(Map<String, dynamic> parsedJSON)
      : contribution = parsedJSON['contribution'],
        contributionId = parsedJSON['contribution_id'],
        fullName = parsedJSON['full_name'],
        isOfficial = parsedJSON['is_official'],
        timeStamp = parsedJSON['time_stamp'],
        username = parsedJSON['username'];
}
