class Imagen {
  final String url;

  Imagen(this.url);
  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}
