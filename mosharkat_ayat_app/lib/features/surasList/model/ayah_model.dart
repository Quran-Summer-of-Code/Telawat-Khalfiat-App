class Ayah {
  final int rakam;
  final String ayah;
  final String tafsir;

  Ayah({required this.rakam, required this.ayah, required this.tafsir});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      rakam: json['rakam'],
      ayah: json['ayah'],
      tafsir: json['tafsir'],
    );
  }
}
