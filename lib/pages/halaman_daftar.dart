import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tugas_kuliah.dart';
import '../providers/tugas_provider.dart';

enum FilterTugas { semua, aktif, selesai }

class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  FilterTugas _filterAktif = FilterTugas.semua; // Ephemeral state (setState)

  String _formatTanggal(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    return '$d/$m/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TugasProvider>();
    final List<TugasKuliah> tugasTersaring = provider.semuaTugas.where((item) {
      switch (_filterAktif) {
        case FilterTugas.semua:
          return true;
        case FilterTugas.aktif:
          return !item.selesai;
        case FilterTugas.selesai:
          return item.selesai;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Tugas Kuliah')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Semua'),
                  selected: _filterAktif == FilterTugas.semua,
                  onSelected: (_) => setState(() => _filterAktif = FilterTugas.semua),
                ),
                FilterChip(
                  label: const Text('Aktif'),
                  selected: _filterAktif == FilterTugas.aktif,
                  onSelected: (_) => setState(() => _filterAktif = FilterTugas.aktif),
                ),
                FilterChip(
                  label: const Text('Selesai'),
                  selected: _filterAktif == FilterTugas.selesai,
                  onSelected: (_) => setState(() => _filterAktif = FilterTugas.selesai),
                ),
              ],
            ),
          ),
          Expanded(
            child: tugasTersaring.isEmpty
                ? const Center(child: Text('Belum ada tugas pada filter ini'))
                : ListView.separated(
                    itemCount: tugasTersaring.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final tugas = tugasTersaring[index];
                      return ListTile(
                        leading: Checkbox(
                          value: tugas.selesai,
                          onChanged: (_) =>
                              context.read<TugasProvider>().toggleSelesai(tugas.id),
                        ),
                        title: Text(
                          tugas.judul,
                          style: TextStyle(
                            decoration: tugas.selesai
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                          '${tugas.mataKuliah} • Tenggat: ${_formatTanggal(tugas.tenggat)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () =>
                              context.read<TugasProvider>().hapusTugas(tugas.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}