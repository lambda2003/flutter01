class TodoList {

  final String imagePath;
  final String title;

  const TodoList({required this.imagePath, required this.title});

  factory TodoList.fromJson(Map<String,dynamic> json){
    return TodoList(
      imagePath: json["imagePath"] as String,
      title: json["title"] as String,
      );
  }

}