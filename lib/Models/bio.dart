class BioInfo {
  String idStructure = "BIO";
  final String info1;
  final String info2;

  BioInfo(this.info1, this.info2);
  factory BioInfo.fromJson(Map<String, dynamic> json) =>
      BioInfo(json["info1"], json["info2"]);

  Map<String, dynamic> toJson() => {"title": info1, "images": info2};
}
