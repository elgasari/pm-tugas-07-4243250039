import 'package:flutter_test/flutter_test.dart';
import 'package:pm_tugas_07_4243250039/models/tugas_kuliah.dart';
import 'package:pm_tugas_07_4243250039/providers/tugas_provider.dart';

void main() {
  group('Unit Test TugasProvider', () {
    test('1. Menambah tugas memperbarui jumlah total dan jumlah aktif', () {
      final provider = TugasProvider();

      provider.tambahTugas(
        judul: 'Laporan Praktikum 7',
        mataKuliah: 'Pemrograman Mobile',
        tenggat: DateTime(2026, 11, 30),
      );

      expect(provider.jumlahTotal, 1);
      expect(provider.jumlahAktif, 1);
      expect(provider.jumlahSelesai, 0);
      expect(provider.semuaTugas.first, isA<TugasKuliah>());
    });

    test('2. Menandai tugas selesai memperbarui jumlah selesai dan persentase', () {
      final provider = TugasProvider();

      provider.tambahTugas(
        judul: 'Tugas 1',
        mataKuliah: 'Pemrograman Mobile',
        tenggat: DateTime(2026, 11, 28),
      );
      provider.tambahTugas(
        judul: 'Tugas 2',
        mataKuliah: 'Pemodelan dan Simulasi',
        tenggat: DateTime(2026, 11, 29),
      );

      final idPertama = provider.semuaTugas.first.id;
      provider.toggleSelesai(idPertama);

      expect(provider.jumlahSelesai, 1);
      expect(provider.jumlahAktif, 1);
      expect(provider.persentaseSelesai, closeTo(50.0, 0.001));
    });

    test('3. Menghapus tugas mengurangi jumlah total dan memperbarui statistik', () {
      final provider = TugasProvider();

      provider.tambahTugas(
        judul: 'Kuis',
        mataKuliah: 'Keamanan Komputer dan Jaringan',
        tenggat: DateTime(2026, 11, 27),
      );
      final id = provider.semuaTugas.first.id;
      provider.toggleSelesai(id);

      provider.hapusTugas(id);

      expect(provider.jumlahTotal, 0);
      expect(provider.jumlahSelesai, 0);
      expect(provider.jumlahAktif, 0);
      expect(provider.persentaseSelesai, 0);
      expect(provider.semuaTugas, isEmpty);
    });
  });
}