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
      this.year_place,
      this.order);

  factory Project.fromJson(Map<String, dynamic> json) => Project(
      json["title"],
      json["year"],
      json["dataENG"],
      json["dataESP"],
      json["descriptionENG"],
      json["descriptionESP"],
      json["dir"],
      json["year_place"],
      json["order"]);

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
  List<String> images;

  @override
  String title;

  @override
  int year;

  @override
  int order;
}
