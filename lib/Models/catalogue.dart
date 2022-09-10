import 'infostructure.dart';

class Catalogue implements InfoStructure {
  @override
  String dir = "";
  final String title;
  final String data;
  final String datasp;
  final String info1;
  final String info2;
  final String info3;
  final String uid;
  final String author;
  final String bod1;
  final String bod2;
  final String bod3;
  final String bod4;

  final List<dynamic> images;

  Catalogue(
      this.title,
      this.data,
      this.datasp,
      this.info1,
      this.info2,
      this.info3,
      this.author,
      this.uid,
      this.images,
      this.dir,
      this.bod1,
      this.bod2,
      this.bod3,
      this.bod4);
  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        json["title"],
        json["data"],
        json["datasp"],
        json["info1"],
        json["info2"],
        json["info3"],
        json["author"],
        json["uid"],
        json["images"],
        json["dir"],
        json["bod1"],
        json["bod2"],
        json["bod3"],
        json["bod4"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "images": images,
        "data": data,
        "datasp": datasp,
        "info1": info1,
        "info2": info2,
        "info3": info3,
        "uid": uid,
        "author": author,
        "dir": dir,
      };

  @override
  String idStructure = "CATALOGUE";

  @override
  set images(List _images) {
    this.images = _images;
  }

  @override
  set title(String _title) {
    this.title = _title;
  }
}
