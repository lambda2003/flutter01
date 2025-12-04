class TodoList {
  int? id;
  String title;
  String? content;
  int? isAlarm;
  int? importance;
  DateTime? startDate;
  DateTime? endDate;
  
  TodoList({
    this.id,
    required this.title,
    this.content,
    this.isAlarm,
    this.startDate,
    this.endDate,
    this.importance,
  });

  TodoList.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      title = json["title"],
      content = json["content"],
      isAlarm = json["isAlarm"],
      startDate = DateTime.parse(json["startDate"]),
      importance = json["importance"];
}
