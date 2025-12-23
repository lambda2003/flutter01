class Todolist {

  int seq;
  String contents;
  String image;
  String? insertdate;

  Todolist({required this.seq, required this.contents, required this.image, this.insertdate});


  factory Todolist.fromJson(Map<String,dynamic> json) {
    return Todolist(
      seq: json['seq'], 
      contents: json['contents'], 
      image: json['image'],
      insertdate:  json['insertdate']
    );
  }

  Map<String,dynamic> toJson(){

    return {
      'seq': seq,
      'contents':contents,
      'image':image,
      'insertdate':insertdate
    };

  }


}