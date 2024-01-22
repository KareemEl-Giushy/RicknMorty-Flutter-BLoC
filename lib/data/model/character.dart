class Character {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  List<dynamic> episodes;
  String image;

  Character(
      {this.id = 0,
      this.name = "",
      this.status = "",
      this.species = "",
      this.type = "",
      this.gender = "",
      this.episodes = const [],
      this.image = ""});

  factory Character.fromJson(json) {
    return Character(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      status: json["status"] ?? "",
      species: json["species"] ?? "",
      type: json["type"] ?? "",
      gender: json["gender"] ?? "",
      episodes: json["episode"] ?? [],
      image: json["image"] ?? "",
    );
  }
}
