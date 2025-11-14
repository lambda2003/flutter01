class Animal {
  final String imagePath;
  final String animalName;
  final String kind;
  final bool flyExist;

  const Animal({
    required this.imagePath,
    required this.animalName,
    required this.kind,
    required this.flyExist,
  });

  // factory AnimalList.fromJson(Map<String, dynamic> json) {
  //   return AnimalList(
  //     imagePath: json['imagePath'] as String,
  //     animalName: json['animalName'] as String,
  //     kind: json['kind'] as String,
  //     flyExist: json['flyExist'] as bool,
  //   );
  // }
}
