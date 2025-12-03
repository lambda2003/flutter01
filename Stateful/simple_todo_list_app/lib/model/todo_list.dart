class TodoList {
  int? id;
  String title;
  String? content;
  int? isAlram;
  int? importance;
  DateTime? startDate;
  DateTime? endDate;
  
  TodoList({this.id,required this.title, this.content, this.isAlram, this.startDate, this.endDate,  this.importance});

  TodoList.fromJson(Map<String,dynamic> json) : 
  id=json["id"],
  title=json["title"],
  content=json["content"],
  isAlram=json["isAlram"],
  startDate=DateTime.parse(json["startDate"]),
  importance=json["importance"]
  ;


} 

