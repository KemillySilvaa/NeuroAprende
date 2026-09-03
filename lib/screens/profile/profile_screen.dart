import 'package:flutter/material.dart';

import 'avatar_customization_screen.dart';
import '../../services/progress_service.dart';
import '../../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final xp = ProgressService.xp;

    final level = (xp ~/ 50) + 1;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // AVATAR
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: ProgressService.selectedAvatarColor,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  children: [

                    Container(
                      width: 120,
                      height: 120,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Icon(
                        ProgressService.selectedAvatar,
                        size: 75,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Meu Avatar',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Nível $level',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // XP
              _InfoCard(
                icon: Icons.star,
                title: 'XP',
                value: '$xp XP',
                color: AppColors.yellow,
              ),

              const SizedBox(height: 15),

              // ATIVIDADES
              _InfoCard(
                icon: Icons.sports_esports,
                title: 'Atividades concluídas',
                value:
                    '${ProgressService.completedActivities}',
                color: AppColors.green,
              ),

              const SizedBox(height: 15),

              // CONQUISTAS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      '🏆 Conquistas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        _Achievement(
                          icon: Icons.play_arrow,
                          title: 'Primeiro jogo',
                          unlocked:
                              ProgressService
                                      .completedActivities >=
                                  1,
                        ),

                        const SizedBox(width: 15),

                        _Achievement(
                          icon: Icons.star,
                          title: '50 XP',
                          unlocked:
                              ProgressService.xp >= 50,
                        ),

                        const SizedBox(width: 15),

                        _Achievement(
                          icon: Icons.emoji_events,
                          title: '5 jogos',
                          unlocked:
                              ProgressService
                                      .completedActivities >=
                                  5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // BOTÃO AVATAR
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAvatarMessage();
                  },

                  icon: const Icon(
                    Icons.edit,
                  ),

                  label: const Text(
                    'Personalizar avatar',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvatarMessage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AvatarCustomizationScreen(),
      ),
    );

    if (result != null) {
      setState(() {});
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),

      child: Row(
        children: [

          Container(
            width: 60,
            height: 60,

            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: 32,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Achievement extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool unlocked;

  const _Achievement({
    required this.icon,
    required this.title,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [

          Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              color: unlocked
                  ? AppColors.yellow
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),

            child: Icon(
              unlocked
                  ? icon
                  : Icons.lock,
              size: 30,
              color: unlocked
                  ? Colors.black
                  : Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: unlocked
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}