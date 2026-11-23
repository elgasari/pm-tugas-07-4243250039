class TugasKuliah {
  TugasKuliah({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    this.selesai = false,
  });

  final String id;
  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  bool selesai;
}