import 'infostructure.dart';

class Catalogue implements InfoStructure {
  Catalogue(
      this.title,
      this.year,
      this.dataENG,
      this.dataESP,
      this.descriptionENG,
      this.descriptionESP,
      this.dir,
      this.order,
      this.isHtml,
      this.frontPage);

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
      json["title"],
      json["year"],
      json["dataENG"],
      json["dataESP"],
      json["descriptionENG"],
      json["descriptionESP"],
      json["dir"],
      json["order"],
      json["isHtml"],
      json["frontPage"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "year": year,
        "dataENG": dataENG,
        "dataESP": dataESP,
        "descriptionENG": descriptionENG,
        "descriptionESP": descriptionESP,
        "images": images,
        "isHtml": isHtml,
        "frontPage": frontPage
      };

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
  int year;

  @override
  List<String> images;

  @override
  int order;

  @override
  int frontPage;

  @override
  bool isHtml;
}
