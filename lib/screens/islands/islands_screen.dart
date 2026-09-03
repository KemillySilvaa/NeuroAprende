
import '../activities/attention_activities_screen.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class IslandsScreen extends StatelessWidget {
  const IslandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Minhas Ilhas',
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

              const Text(
                'Escolha uma ilha 🌴',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Cada ilha possui desafios diferentes para você aprender brincando!',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 25),

              _IslandCard(
                title: 'Ilha da Atenção',
                description:
                    'Desafios para exercitar sua concentração.',
                icon: Icons.psychology,
                color: AppColors.blue,
                progress: 0.35,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AttentionActivitiesScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              _IslandCard(
                title: 'Ilha das Palavras',
                description:
                    'Aprenda, leia e descubra novas palavras.',
                icon: Icons.menu_book,
                color: AppColors.green,
                progress: 0.20,
                onTap: () {},
              ),

              const SizedBox(height: 18),

              _IslandCard(
                title: 'Ilha da Matemática',
                description:
                    'Resolva desafios matemáticos divertidos.',
                icon: Icons.calculate,
                color: AppColors.yellow,
                progress: 0.10,
                onTap: () {},
              ),

              const SizedBox(height: 18),

              _IslandCard(
                title: 'Ilha da Memória',
                description:
                    'Treine sua memória com jogos divertidos.',
                icon: Icons.memory,
                color: const Color(0xFFD7C5FF),
                progress: 0.0,
                locked: true,
                onTap: () {},
              ),

              const SizedBox(height: 18),

              _IslandCard(
                title: 'Ilha dos Desafios',
                description:
                    'Novos desafios estão esperando por você!',
                icon: Icons.emoji_events,
                color: const Color(0xFFFFC9A9),
                progress: 0.0,
                locked: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IslandCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final double progress;
  final bool locked;
  final VoidCallback onTap;

  const _IslandCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
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
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(28),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            children: [

              // PARTE SUPERIOR DO CARD
              Row(
                children: [

                  Container(
                    width: 75,
                    height: 75,

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      icon,
                      size: 42,
                    ),
                  ),
                
                  const SizedBox(width: 18),

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
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            if (locked)
                              const Icon(
                                Icons.lock,
                                size: 22,
                              ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // PROGRESSO
              if (!locked) ...[
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Progresso',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),

                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor:
                        Colors.white.withOpacity(0.6),
                  ),
                ),
              ]

              // ILHA BLOQUEADA
              else
                const Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    '🔒 Complete outras atividades para desbloquear',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

