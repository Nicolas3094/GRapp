class Description {
  final String descriptionESP;
  final String descriptionENG;

  Description(this.descriptionENG, this.descriptionESP);

  factory Description.fromJson(Map<String, dynamic> json) =>
      Description(json["descriptionENG"], json["descriptionESP"]);
}
