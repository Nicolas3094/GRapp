import 'infostructure.dart';

class Project implements InfoStructure {
  @override
  String idStructure = "PROJECTS";
  final String title;
  final String dir;
  final String titulo;
  final String lugar;
  final String subtitulo;
  final String cuerpo;
  final String web;
  final String tit1;
  final String tit2;
  final String tit3;
  final String tit4;
  final String bod1;
  final String bod2;
  final String bod3;
  final String bod4;
  final String web1;
  final String web2;
  final String web3;
  final String web4;
  final List<dynamic> images;

  Project(
      this.title,
      this.dir,
      this.images,
      this.titulo,
      this.lugar,
      this.subtitulo,
      this.cuerpo,
      this.web,
      this.bod1,
      this.bod2,
      this.bod3,
      this.bod4,
      this.tit1,
      this.tit2,
      this.tit3,
      this.tit4,
      this.web1,
      this.web2,
      this.web3,
      this.web4);
  factory Project.fromJson(Map<String, dynamic> json) => Project(
        json["title"],
        json["dir"],
        json["images"],
        json["titulo"],
        json["lugar"],
        json["subtitulo"],
        json["cuerpo"],
        json["web"],
        json["bod1"],
        json["bod2"],
        json["bod3"],
        json["bod4"],
        json["tit1"],
        json["tit2"],
        json["tit3"],
        json["tit4"],
        json["web1"],
        json["web2"],
        json["web3"],
        json["web4"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "dir": dir,
        "images": images,
        "titulo": titulo,
        "lugar": lugar,
        "subtitulo": subtitulo,
        "cuerpo": cuerpo,
        "web": web
      };

  @override
  set images(List<dynamic> _images) {
    images = _images;
  }

  @override
  set title(String _title) {
    title = _title;
  }

  @override
  set dir(String _dir) {
    dir = _dir;
  }
}
