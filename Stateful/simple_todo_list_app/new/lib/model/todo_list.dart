class TodoList {
  int? id;
  String title;
  String? content;
  int? isAlarm;
  int? importance;
  DateTime? startDate;
  DateTime? endDate;
  int? isDeleted = 0;

  TodoList({
    this.id,
    required this.title,
    this.content,
    this.isAlarm,
    this.startDate,
    this.endDate,
    this.importance,
    this.isDeleted,
  });

  TodoList.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      title = json["title"],
      content = json["content"],
      isAlarm = json["isAlarm"],
      startDate = DateTime.parse(json["startDate"]),
      importance = json["importance"],
      isDeleted = json["isDeleted"];
}
