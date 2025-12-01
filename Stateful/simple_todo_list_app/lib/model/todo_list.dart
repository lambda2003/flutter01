class TodoList {
  int? id;
  String title;
  String? startDate;
  String? endDate;
  
  TodoList({required this.title, this.id, this.startDate, this.endDate});

  TodoList.fromJson(Map<String,dynamic> json) : 
  id=json["id"],
  title=json["title"],
  startDate=json["startDate"]
  ;


} 

