import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tugas_provider.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TugasProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('Total Tugas'),
                trailing: Text(
                  '${provider.jumlahTotal}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text('Tugas Selesai'),
                trailing: Text(
                  '${provider.jumlahSelesai}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.pie_chart),
                title: const Text('Persentase Penyelesaian'),
                trailing: Text(
                  '${provider.persentaseSelesai.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}