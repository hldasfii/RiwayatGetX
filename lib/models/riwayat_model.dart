class History {
  String? lokasi;
  String? judulBuku;
  String? namaPenerbit;
  String? namaPengarang;
  String? tanggalPinjam;
  String? tanggalKembali;
  String? tanggalKembaliRiil;

  History(
      {required this.lokasi, required this.judulBuku, required this.namaPenerbit, required this.namaPengarang, required this.tanggalPinjam, required this.tanggalKembali, required this.tanggalKembaliRiil});

  History.fromJson(Map<String, dynamic> json) {
    lokasi = json['Lokasi'];
    judulBuku = json['JudulBuku'];
    namaPenerbit = json['NamaPenerbit'];
    namaPengarang = json['NamaPengarang'];
    tanggalPinjam = json['TanggalPinjam'];
    tanggalKembali = json['TanggalKembali'];
    tanggalKembaliRiil = json['TanggalKembaliRiil'];

  }
}

class RiwayatResponse {
  List<History>? data;
  int? total;
  bool? success;
  String? message;

  RiwayatResponse(
      {this.data, this.total, this.success, this.message});

  RiwayatResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <History>[];
      json['Data'].forEach((v) {
        data?.add(new History.fromJson(v));
      });
    }
    total = json['Total'];
    success = json['Success'];
    message = json['Message'];
  }
}