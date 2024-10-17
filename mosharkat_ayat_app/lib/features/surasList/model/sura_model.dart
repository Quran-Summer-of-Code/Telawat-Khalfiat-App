class Sura {
  final String name;
  final String order;
  final String page;
  final String numAyas;
  final String locType;
  final String wahyOrder;
  final String hasSagda;
  final String fontName;
  final String fontFamily;
  final int firstAyah;

  Sura({
    required this.name,
    required this.order,
    required this.page,
    required this.numAyas,
    required this.locType,
    required this.wahyOrder,
    required this.hasSagda,
    required this.fontName,
    required this.fontFamily,
    required this.firstAyah,
  });

  factory Sura.fromJson(Map<String, dynamic> json) {
    return Sura(
      name: json['name'],
      order: json['order'],
      page: json['page'],
      numAyas: json['numAyas'],
      locType: json['locType'],
      wahyOrder: json['wahyOrder'],
      hasSagda: json['hasSagda'],
      fontName: json['fontName'],
      fontFamily: json['fontFamily'],
      firstAyah: json['firstAyah'],
    );
  }
}
