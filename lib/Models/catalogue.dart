import 'infostructure.dart';

class Catalogue implements InfoStructure {
  final List<dynamic> images;

  Catalogue(this.title, this.year, this.dataENG, this.dataESP,
      this.descriptionENG, this.descriptionESP, this.dir, this.images);

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
      json["title"],
      json["year"],
      json["dataENG"],
      json["dataESP"],
      json["descriptionENG"],
      json["descriptionESP"],
      json["dir"],
      json["images"]);

  Map<String, dynamic> toJson() => {};

  @override
  String idStructure = "CATALOGUE";

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
  String title;

  @override
  String year;

  @override
  set images(List _images) {
    images = _images;
  }
}
