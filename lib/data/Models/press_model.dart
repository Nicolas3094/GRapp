class Press {
  final int order;

  final String title;

  final String link;

  final String fechaESP;

  final String fechaENG;

  Press({this.order, this.title, this.link, this.fechaENG, this.fechaESP});

  factory Press.fromJson(Map<String, dynamic> json) => Press(
      order: json["order"],
      title: json["title"],
      link: json["link"],
      fechaESP: json["fechaESP"],
      fechaENG: json["fechaENG"]);
}
