import '../../services/progress_service.dart';
import '../games/complete_pattern_game.dart';
import '../games/find_different_game.dart';
import '../games/memory_visual_game.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AttentionActivitiesScreen extends StatelessWidget {
  const AttentionActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Ilha da Atenção',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // CABEÇALHO
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(28),
                ),

                child: const Row(
                  children: [

                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.psychology,
                        size: 42,
                      ),
                    ),

                    SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            'Vamos treinar a atenção! 🧠',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Escolha uma atividade para começar.',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Atividades',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // ATIVIDADE 1
              _ActivityCard(
                title: 'Encontre o diferente',
                description:
                    'Observe as figuras e encontre aquela que é diferente.',
                icon: Icons.search,
                color: AppColors.yellow,
                level: 'Fácil',
                xp: 10,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const FindDifferentGame(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // ATIVIDADE 2
              _ActivityCard(
                title: 'Complete o padrão',
                description:
                    'Observe a sequência e escolha a figura que completa o padrão.',
                icon: Icons.extension,
                color: AppColors.green,
                level: 'Fácil',
                xp: 10,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const CompletePatternGame(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // ATIVIDADE 3
            // ATIVIDADE 3
              _ActivityCard(
                title: 'Memória visual',
                description:
                    'Observe as figuras e encontre os pares iguais.',
                icon: Icons.visibility,
                color: const Color(0xFFD7C5FF),
                level: 'Médio',
                xp: 40,

                locked:
                    ProgressService.completedActivities < 1,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MemoryVisualGame(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // ATIVIDADE 4
             _ActivityCard(
                title: 'Desafio da concentração',
                description:
                    'Complete o desafio mantendo o foco até o final.',
                icon: Icons.track_changes,
                color: const Color(0xFFFFC9A9),
                level: 'Difícil',
                xp: 30,

                locked:
                    ProgressService.completedActivities < 3,

                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String level;
  final int xp;
  final bool locked;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.level,
    required this.xp,
    required this.onTap,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: locked ? null : onTap,

      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: locked ? 0.55 : 1,

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Row(
            children: [

              Container(
                width: 65,
                height: 65,

                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  icon,
                  size: 34,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        if (locked)
                          const Icon(
                            Icons.lock,
                            size: 20,
                          ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),

                          child: Text(
                            level,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          '+$xp XP ⭐',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                locked
                    ? Icons.lock
                    : Icons.arrow_forward_ios,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}