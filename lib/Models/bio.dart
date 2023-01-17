class BioInfo {
  String idStructure = "BIO";
  final String info1;
  final String info2;
  final List<dynamic> list1;
  final List<dynamic> list2;

  BioInfo(this.info1, this.list1, this.info2, this.list2);
  factory BioInfo.fromJson(Map<String, dynamic> json) =>
      BioInfo(json["info1"], json["list1"], json["info2"], json["list2"]);

  Map<String, dynamic> toJson() =>
      {"info1": info1, "info2": info2, "list1": list1, "list2": list2};
}
