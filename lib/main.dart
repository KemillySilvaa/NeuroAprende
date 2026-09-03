import 'package:flutter/material.dart';

import 'screens/profile_selection/profile_selection_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NeuroAprendeApp());
}

class NeuroAprendeApp extends StatelessWidget {
  const NeuroAprendeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroAprende',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ProfileSelectionScreen(),
    );
  }
}

