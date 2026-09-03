import 'package:flutter/material.dart';

import '../../services/progress_service.dart';
import '../../theme/app_colors.dart';

import '../islands/islands_screen.dart';
import '../profile/profile_screen.dart';
import '../progress/progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // =========================================================
  // ATUALIZAR A HOME
  // =========================================================

  void _refreshHome() {
    setState(() {});
  }

  // =========================================================
  // ABRIR PERFIL
  // =========================================================

  Future<void> _openProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );

    // Quando voltar do Perfil, atualiza a Home.
    _refreshHome();
  }

  // =========================================================
  // ABRIR PROGRESSO
  // =========================================================

  Future<void> _openProgress() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProgressScreen(),
      ),
    );

    // Quando voltar do progresso, atualiza a Home.
    _refreshHome();
  }

  // =========================================================
  // ABRIR ILHAS
  // =========================================================

  Future<void> _openIslands() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const IslandsScreen(),
      ),
    );

    _refreshHome();
  }

  @override
  Widget build(BuildContext context) {
    // =======================================================
    // DADOS ATUAIS DO JOGADOR
    // =======================================================

    final progress = ProgressService.progress;
    final xp = ProgressService.xp;
    final level = ProgressService.level;

    final avatar = ProgressService.selectedAvatar;
    final avatarColor =
        ProgressService.selectedAvatarColor;

    return Scaffold(
      backgroundColor: AppColors.background,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        title: const Text('NeuroAprende'),

        actions: [
          IconButton(
            icon: const Icon(Icons.person),

            onPressed: _openProfile,
          ),
        ],
      ),

      // =====================================================
      // CORPO
      // =====================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // =================================================
              // SAUDAÇÃO
              // =================================================

              const Text(
                'Olá! 👋',

                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Vamos aprender brincando?',

                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),

              // =================================================
              // CARD DO PERFIL
              // =================================================

              GestureDetector(
                onTap: _openProfile,

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(25),
                  ),

                  child: Row(
                    children: [

                      // AVATAR
                      Container(
                        width: 70,
                        height: 70,

                        decoration: BoxDecoration(
                          color: avatarColor,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          avatar,
                          size: 45,
                        ),
                      ),

                      const SizedBox(width: 15),

                      // INFORMAÇÕES
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(
                              'Meu Perfil',

                              style: TextStyle(
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'Nível $level • $xp XP',

                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 3),

                            const Text(
                              'Continue sua jornada!',

                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // ATIVIDADES
              // =================================================

              const Text(
                'Escolha uma atividade',

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // ILHA DA ATENÇÃO
              _IslandCard(
                title: 'Ilha da Atenção',
                subtitle:
                    'Exercite sua concentração',
                icon: Icons.psychology,
                color: AppColors.blue,
                onTap: _openIslands,
              ),

              const SizedBox(height: 15),

              // ILHA DAS PALAVRAS
              _IslandCard(
                title: 'Ilha das Palavras',
                subtitle:
                    'Aprenda novas palavras',
                icon: Icons.menu_book,
                color: AppColors.green,

                // Ainda será implementada.
                onTap: () {},
              ),

              const SizedBox(height: 15),

              // ILHA DA MATEMÁTICA
              _IslandCard(
                title: 'Ilha da Matemática',
                subtitle:
                    'Resolva desafios divertidos',
                icon: Icons.calculate,
                color: AppColors.yellow,

                // Ainda será implementada.
                onTap: () {},
              ),

              const SizedBox(height: 30),

              // =================================================
              // PROGRESSO
              // =================================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [

                        const Text(
                          'Meu progresso',

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Nível $level',

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // BARRA REAL
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10),

                      child:
                          LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // PORCENTAGEM REAL
                    Text(
                      '${(progress * 100).toInt()}% concluído',

                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '${ProgressService.completedActivities} de '
                      '${ProgressService.totalActivities} atividades',

                      style: TextStyle(
                        fontSize: 14,
                        color:
                            Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // XP
                    Row(
                      children: [

                        const Text(
                          '⭐',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          '$xp XP conquistado',

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // BOTÃO VER PROGRESSO
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 52,

                child: OutlinedButton.icon(
                  onPressed: _openProgress,

                  icon: const Icon(
                    Icons.bar_chart,
                  ),

                  label: const Text(
                    'Ver meu progresso',

                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // =======================================================
      // MENU INFERIOR
      // =======================================================

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.08),

              blurRadius: 10,

              offset:
                  const Offset(0, -3),
            ),
          ],
        ),

        child: BottomNavigationBar(
          currentIndex: 0,

          backgroundColor:
              Colors.white,

          selectedItemColor:
              AppColors.primary,

          unselectedItemColor:
              Colors.grey.shade700,

          selectedIconTheme:
              const IconThemeData(
            size: 28,
          ),

          unselectedIconTheme:
              const IconThemeData(
            size: 28,
          ),

          selectedLabelStyle:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 14,
          ),

          unselectedLabelStyle:
              const TextStyle(
            fontSize: 14,
          ),

          type:
              BottomNavigationBarType.fixed,

          showSelectedLabels: true,

          showUnselectedLabels: true,

          onTap: (index) async {

            if (index == 1) {
              await _openIslands();
            }

            if (index == 2) {
              await _openProgress();
            }

            if (index == 3) {
              await _openProfile();
            }
          },

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),

            BottomNavigationBarItem(
              icon:
                  Icon(Icons.sports_esports),
              label: 'Jogos',
            ),

            BottomNavigationBarItem(
              icon:
                  Icon(Icons.bar_chart),
              label: 'Progresso',
            ),

            BottomNavigationBarItem(
              icon:
                  Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// CARD DAS ILHAS
// ===========================================================

class _IslandCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _IslandCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color,
          borderRadius:
              BorderRadius.circular(25),
        ),

        child: Row(
          children: [

            Container(
              width: 65,
              height: 65,

              decoration:
                  const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 38,
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
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,

                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

