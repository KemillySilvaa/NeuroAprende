import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/profile_button.dart';
import '../login/login_screen.dart';

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      debugPrint('Música');
                    },
                    icon: const Icon(
                      Icons.music_note_rounded,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      debugPrint('Configurações');
                    },
                    icon: const Icon(
                      Icons.settings_rounded,
                      size: 34,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              const Icon(
                Icons.psychology_rounded,
                size: 110,
                color: AppColors.primary,
              ),

              const SizedBox(height: 12),

              const Text(
                'NeuroAprende',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 50),

              ProfileButton(
  text: 'Usuário',
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  },
),

const SizedBox(height: 18),

ProfileButton(
  text: 'Professor',
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  },
),

const SizedBox(height: 18),

ProfileButton(
  text: 'Responsável',
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  },
),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}