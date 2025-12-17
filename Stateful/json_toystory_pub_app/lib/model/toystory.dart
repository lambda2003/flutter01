class Toystory {
  String title;
  String image;

  Toystory({required this.title, required this.image});

  Toystory.parseJson(Map<String,dynamic> json) :
  title = json['title'],
  image = json['image'];
}