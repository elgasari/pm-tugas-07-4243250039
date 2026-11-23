import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/tugas_provider.dart';

class HalamanTambah extends StatefulWidget {
  const HalamanTambah({super.key});

  @override
  State<HalamanTambah> createState() => _HalamanTambahState();
}

class _HalamanTambahState extends State<HalamanTambah> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulController;
  late final TextEditingController _matkulController;
  DateTime _tenggatDipilih = DateTime.now().add(const Duration(days: 3));

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController();
    _matkulController = TextEditingController();
  }

  @override
  void dispose() {
    _judulController.dispose();
    _matkulController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tenggatDipilih,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (!mounted || hasil == null) return;
    setState(() => _tenggatDipilih = hasil);
  }

  void _simpanTugas() {
    if (!_formKey.currentState!.validate()) return;
    context.read<TugasProvider>().tambahTugas(
          judul: _judulController.text,
          mataKuliah: _matkulController.text,
          tenggat: _tenggatDipilih,
        );
    _judulController.clear();
    _matkulController.clear();
    context.go('/daftar');
  }

  @override
  Widget build(BuildContext context) {
    final tgl =
        '${_tenggatDipilih.day.toString().padLeft(2, '0')}/${_tenggatDipilih.month.toString().padLeft(2, '0')}/${_tenggatDipilih.year}';

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matkulController,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Mata kuliah wajib diisi'
                    : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tenggat Waktu'),
                subtitle: Text(tgl),
                trailing: OutlinedButton.icon(
                  onPressed: _pilihTanggal,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pilih Tanggal'),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _simpanTugas,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Tugas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}