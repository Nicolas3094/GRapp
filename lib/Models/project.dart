import 'infostructure.dart';

class Project implements InfoStructure {
  String year_place;

  @override
  String idStructure = "PROJECTS";

  Project(
      this.title,
      this.year,
      this.dataENG,
      this.dataESP,
      this.descriptionENG,
      this.descriptionESP,
      this.dir,
      this.images,
      this.year_place);

  factory Project.fromJson(Map<String, dynamic> json) => Project(
      json["title"],
      json["year"],
      json["dataENG"],
      json["dataESP"],
      json["descriptionENG"],
      json["descriptionESP"],
      json["dir"],
      json["images"],
      json["year_place"]);

  Map<String, dynamic> toJson() => {};

  @override
  String dataENG;

  @override
  String dataESP;

  @override
  String descriptionENG;

  @override
  String descriptionESP;

  @override
  String dir;

  @override
  List images;

  @override
  String title;

  @override
  String year;
}
