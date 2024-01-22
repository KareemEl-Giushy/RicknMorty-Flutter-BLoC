class Episode {
  int id;
  String name;
  String airDate;
  String episode;

  Episode({this.id = 0, this.name = "", this.airDate = "", this.episode = ""});

  factory Episode.fromJson(json) {
    return Episode(
      id: json["id"],
      name: json["name"],
      airDate: json["air_date"],
      episode: json["episode"],
    );
  }
}
