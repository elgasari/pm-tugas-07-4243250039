import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'pages/halaman_daftar.dart';
import 'pages/halaman_statistik.dart';
import 'pages/halaman_tambah.dart';
import 'providers/tugas_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TugasProvider(),
      child: const PlannerTugasApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/daftar',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final jumlahAktif =
            context.select((TugasProvider p) => p.jumlahAktif);

        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            destinations: [
              NavigationDestination(
                icon: Badge.count(
                  count: jumlahAktif,
                  isLabelVisible: jumlahAktif > 0,
                  child: const Icon(Icons.checklist),
                ),
                label: 'Daftar',
              ),
              const NavigationDestination(
                icon: Icon(Icons.add_task),
                label: 'Tambah',
              ),
              const NavigationDestination(
                icon: Icon(Icons.bar_chart),
                label: 'Statistik',
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/daftar',
              builder: (context, state) => const HalamanDaftar(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tambah',
              builder: (context, state) => const HalamanTambah(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistik',
              builder: (context, state) => const HalamanStatistik(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class PlannerTugasApp extends StatelessWidget {
  const PlannerTugasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Planner Tugas Kuliah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(177, 210, 40, 187)),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}