
class TodoList {  
  // Field
  String imagePath; // 이미지 경로
  String workList; // 할일 내용

  // Consturctor
  TodoList({required this.imagePath, required this.workList});

  // Method
  factory TodoList.fromJson(Map<String,dynamic> json){
    return TodoList(imagePath: json['imagePath'], workList: json['workList']);
  }
}