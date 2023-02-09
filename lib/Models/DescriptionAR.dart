import 'infostructure.dart';

class DescriptionAR implements InfoStructureAR {
  String year_place;

  @override
  String dataENG;

  @override
  String dataESP;

  @override
  String dir;

  @override
  List<String> images;

  @override
  int order;

  @override
  String title;

  @override
  int year;

  DescriptionAR(
      {this.dataENG,
      this.dataESP,
      this.dir,
      this.order,
      this.title,
      this.year,
      this.year_place});

  factory DescriptionAR.fromJson(Map<String, dynamic> json) => DescriptionAR(
      title: json["title"],
      year: json["year"],
      dataENG: json["dataENG"],
      dataESP: json["dataESP"],
      dir: json["dir"],
      year_place: json["year_place"],
      order: json["order"]);
}
