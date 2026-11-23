import 'package:flutter/foundation.dart';
import '../models/tugas_kuliah.dart';

class TugasProvider extends ChangeNotifier {
  final List<TugasKuliah> _daftarTugas = [];

  List<TugasKuliah> get semuaTugas => List.unmodifiable(_daftarTugas);

  int get jumlahTotal => _daftarTugas.length;

  int get jumlahSelesai => _daftarTugas.where((item) => item.selesai).length;

  int get jumlahAktif => _daftarTugas.where((item) => !item.selesai).length;

  double get persentaseSelesai {
    if (jumlahTotal == 0) return 0;
    return (jumlahSelesai / jumlahTotal) * 100;
  }

  void tambahTugas({
    required String judul,
    required String mataKuliah,
    required DateTime tenggat,
  }) {
    _daftarTugas.add(
      TugasKuliah(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        judul: judul.trim(),
        mataKuliah: mataKuliah.trim(),
        tenggat: tenggat,
      ),
    );
    notifyListeners();
  }

  void toggleSelesai(String id) {
    final index = _daftarTugas.indexWhere((item) => item.id == id);
    if (index == -1) return;
    _daftarTugas[index].selesai = !_daftarTugas[index].selesai;
    notifyListeners();
  }

  void hapusTugas(String id) {
    _daftarTugas.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}