class DescriptionAR {
  final String dataESP;
  final String dataENG;
  final String dir;
  final int order;
  final String title;
  final int year;
  final String year_place;
  List<String> images;

  DescriptionAR(
      {this.dataESP,
      this.dataENG,
      this.dir,
      this.order,
      this.title,
      this.year,
      this.year_place});

  factory DescriptionAR.fromJson(Map<String, dynamic> json) => DescriptionAR(
      dataENG: json["dataENG"],
      dataESP: json["dataESP"],
      dir: json["dir"],
      order: json["order"],
      title: json["title"],
      year: json["year"],
      year_place: json["year_place"]);
}
