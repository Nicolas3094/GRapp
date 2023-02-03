class BioInfo {
  String idStructure = "BIO";
  final String descriptionESP;
  final String descriptionENG;
  final String img;

  BioInfo(this.descriptionESP, this.descriptionENG, this.img);

  factory BioInfo.fromJson(Map<String, dynamic> json) =>
      BioInfo(json["descriptionESP"], json["descriptionENG"], json["img"]);

  Map<String, dynamic> toJson() => {
        "descriptionESP": descriptionESP,
        "descriptionENG": descriptionENG,
        "img": img
      };
}
