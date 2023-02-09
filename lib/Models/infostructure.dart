abstract class InfoStructure extends InfoStructureAR {
  String idStructure;
  String descriptionENG;
  String descriptionESP;
}

abstract class InfoStructureAR {
  String title;
  int year;
  String dir;
  String dataENG;
  String dataESP;
  int order;
  List<String> images;
}
