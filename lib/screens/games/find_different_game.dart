import 'dart:math';

import 'package:flutter/material.dart';
import '../../services/progress_service.dart';
import '../../theme/app_colors.dart';

class FindDifferentGame extends StatefulWidget {
  const FindDifferentGame({super.key});

  @override
  State<FindDifferentGame> createState() =>
      _FindDifferentGameState();
}

class _FindDifferentGameState extends State<FindDifferentGame> {
  final Random _random = Random();

  int _round = 1;
  final int _totalRounds = 5;

  int _lives = 3;
  int _xp = 0;

  int _differentIndex = 2;

  bool? _lastAnswerCorrect;

  bool _finished = false;

  List<Color> _options = [];

  @override
  void initState() {
    super.initState();
    _createRound();
  }

  void _createRound() {
    final baseColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];

    final baseColor =
        baseColors[_random.nextInt(baseColors.length)];

    Color differentColor;

    do {
      differentColor =
          baseColors[_random.nextInt(baseColors.length)];
    } while (differentColor == baseColor);

    _differentIndex = _random.nextInt(4);

    _options = List.generate(
      4,
      (index) =>
          index == _differentIndex
              ? differentColor
              : baseColor,
    );
  }

  void _selectOption(int index) {
    if (_lastAnswerCorrect != null) {
      return;
    }

    final correct = index == _differentIndex;

    setState(() {
      _lastAnswerCorrect = correct;

      if (correct) {
        _xp += 10;
      } else {
        _lives--;

        if (_lives <= 0) {
          _finished = true;
        }
      }
    });
  }

  void _nextRound() {
      if (_round >= _totalRounds) {
      ProgressService.completeActivity(
        xpReward: _xp,
      );

      setState(() {
        _finished = true;
      });

      return;
    }

    setState(() {
      _round++;
      _lastAnswerCorrect = null;
      _createRound();
    });
  }

  void _restartGame() {
    setState(() {
      _round = 1;
      _lives = 3;
      _xp = 0;
      _lastAnswerCorrect = null;
      _finished = false;

      _createRound();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) {
      return _buildFinishedScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Encontre o Diferente',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // TOPO
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  // VIDAS
                  Row(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding:
                            const EdgeInsets.only(right: 4),

                        child: Icon(
                          Icons.favorite,
                          color: index < _lives
                              ? Colors.red
                              : Colors.grey.shade300,
                          size: 28,
                        ),
                      ),
                    ),
                  ),

                  // XP
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Text(
                      '⭐ $_xp XP',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // PROGRESSO
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  Text(
                    'Rodada $_round de $_totalRounds',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  Text(
                    '${((_round - 1) / _totalRounds * 100).toInt()}%',
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
                  value:
                      (_round - 1) / _totalRounds,
                  minHeight: 10,
                  backgroundColor:
                      Colors.white.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 35),

              // PERGUNTA
              const Text(
                'Qual figura é diferente?',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Observe com atenção e toque na figura diferente.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 35),

              // OPÇÕES
              Expanded(
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                  ),

                  itemCount: _options.length,

                  itemBuilder: (context, index) {
                    return _buildOption(index);
                  },
                ),
              ),

              // FEEDBACK
              if (_lastAnswerCorrect != null)
                _buildFeedback(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    Color borderColor = Colors.transparent;

    if (_lastAnswerCorrect != null &&
        index == _differentIndex) {
      borderColor = Colors.green;
    }

    return GestureDetector(
      onTap: () => _selectOption(index),

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(30),

          border: Border.all(
            color: borderColor,
            width: 5,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Center(
          child: Container(
            width: 85,
            height: 85,

            decoration: BoxDecoration(
              color: _options[index],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    final correct = _lastAnswerCorrect!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: correct
            ? Colors.green.shade100
            : Colors.red.shade100,

        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          Icon(
            correct
                ? Icons.check_circle
                : Icons.cancel,

            color:
                correct ? Colors.green : Colors.red,

            size: 30,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              correct
                  ? 'Muito bem! Você encontrou! 🎉'
                  : 'Quase! Observe novamente com atenção.',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),

          if (correct)
            ElevatedButton(
              onPressed: _nextRound,
              child: const Text('Próximo'),
            ),
        ],
      ),
    );
  }

  Widget _buildFinishedScreen() {
    final bool won = _lives > 0;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                Text(
                  won ? '🎉' : '💙',
                  style: const TextStyle(
                    fontSize: 80,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  won
                      ? 'Parabéns!'
                      : 'Não desista!',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  won
                      ? 'Você completou o desafio!'
                      : 'Vamos tentar novamente?',
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(25),
                  ),

                  child: Column(
                    children: [

                      const Text(
                        'Sua pontuação',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '⭐ $_xp XP',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: _restartGame,

                    child: const Text(
                      'Jogar novamente',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      'Voltar para atividades',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}