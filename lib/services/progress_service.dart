import 'package:flutter/material.dart';

class ProgressService {
  // =========================
  // PROGRESSO DO JOGADOR
  // =========================

  static int xp = 0;

  static int completedActivities = 0;

  // Quantidade total de atividades planejadas.
  // Podemos aumentar esse número conforme criarmos
  // novos jogos.
  static const int totalActivities = 10;

  // =========================
  // AVATAR
  // =========================

  static IconData selectedAvatar = Icons.face;

  static Color selectedAvatarColor =
      const Color(0xFF9ED8FF);

  // =========================
  // SALVAR AVATAR
  // =========================

  static void saveAvatar({
    required IconData avatar,
    required Color color,
  }) {
    selectedAvatar = avatar;
    selectedAvatarColor = color;
  }

  // =========================
  // ADICIONAR XP
  // =========================

  static void addXp(int amount) {
    xp += amount;
  }

  // =========================
  // CONCLUIR ATIVIDADE
  // =========================

  static void completeActivity({
    int xpReward = 10,
  }) {
    completedActivities++;

    addXp(xpReward);
  }

  // =========================
  // PROGRESSO
  // =========================

  static double get progress {
    if (totalActivities == 0) {
      return 0;
    }

    final value =
        completedActivities / totalActivities;

    // Garante que nunca passe de 100%.
    return value.clamp(0.0, 1.0);
  }

  // =========================
  // NÍVEL
  // =========================

  static int get level {
    return (xp ~/ 50) + 1;
  }

  // =========================
  // XP PARA O PRÓXIMO NÍVEL
  // =========================

  static int get xpForNextLevel {
    return level * 50;
  }

  // =========================
  // RESETAR PROGRESSO
  // =========================

  static void resetProgress() {
    xp = 0;
    completedActivities = 0;

    // Volta o avatar para o padrão.
    selectedAvatar = Icons.face;
    selectedAvatarColor =
        const Color(0xFF9ED8FF);
  }
}

