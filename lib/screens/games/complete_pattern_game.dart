import 'dart:math';

import 'package:flutter/material.dart';

import '../../services/progress_service.dart';
import '../../theme/app_colors.dart';

class CompletePatternGame extends StatefulWidget {
  const CompletePatternGame({super.key});

  @override
  State<CompletePatternGame> createState() =>
      _CompletePatternGameState();
}

class _CompletePatternGameState
    extends State<CompletePatternGame> {
  final Random _random = Random();

  int _round = 1;
  final int _totalRounds = 5;

  int _lives = 3;
  int _xp = 0;

  int _correctAnswer = 0;
  int? _selectedAnswer;

  bool _finished = false;

  final List<IconData> _icons = [
    Icons.star,
    Icons.favorite,
    Icons.circle,
    Icons.square,
    Icons.change_history,
  ];

  IconData _firstIcon = Icons.star;
  IconData _secondIcon = Icons.favorite;
  IconData _thirdIcon = Icons.star;

  void _createRound() {
    final first = _random.nextInt(_icons.length);
    final second = _random.nextInt(_icons.length);

    _firstIcon = _icons[first];
    _secondIcon = _icons[second];
    _thirdIcon = _firstIcon;

    _correctAnswer = _random.nextInt(3);

    _selectedAnswer = null;
  }

  @override
  void initState() {
    super.initState();
    _createRound();
  }

  void _selectAnswer(int answer) {
    if (_selectedAnswer != null) {
      return;
    }

    final correct = answer == _correctAnswer;

    setState(() {
      _selectedAnswer = answer;

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
      ProgressService.addXp(_xp);
      ProgressService.completeActivity();

      setState(() {
        _finished = true;
      });

      return;
    }

    setState(() {
      _round++;
      _createRound();
    });
  }

  void _restartGame() {
    setState(() {
      _round = 1;
      _lives = 3;
      _xp = 0;
      _selectedAnswer = null;
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
          'Complete o Padrão',
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

                  Row(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding:
                            const EdgeInsets.only(right: 4),

                        child: Icon(
                          Icons.favorite,
                          size: 28,
                          color: index < _lives
                              ? Colors.red
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),

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
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // RODADA
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
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'Complete o padrão! 🧩',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Observe a sequência e escolha o que vem depois.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 35),

              // SEQUÊNCIA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,

                  children: [

                    _PatternIcon(
                      icon: _firstIcon,
                    ),

                    const Icon(
                      Icons.arrow_forward,
                      size: 28,
                    ),

                    _PatternIcon(
                      icon: _secondIcon,
                    ),

                    const Icon(
                      Icons.arrow_forward,
                      size: 28,
                    ),

                    _PatternIcon(
                      icon: _thirdIcon,
                    ),

                    const Icon(
                      Icons.arrow_forward,
                      size: 28,
                    ),

                    Container(
                      width: 60,
                      height: 60,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.question_mark,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              const Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Qual figura completa o padrão?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // RESPOSTAS
              Expanded(
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),

                  itemCount: 3,

                  itemBuilder: (context, index) {
                    return _buildAnswer(index);
                  },
                ),
              ),

              if (_selectedAnswer != null)
                _buildFeedback(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswer(int index) {
    final isSelected =
        _selectedAnswer == index;

    final isCorrect =
        index == _correctAnswer;

    Color borderColor =
        Colors.transparent;

    if (_selectedAnswer != null) {
      if (isCorrect) {
        borderColor = Colors.green;
      } else if (isSelected) {
        borderColor = Colors.red;
      }
    }

    IconData icon;

    if (index == _correctAnswer) {
      icon = _thirdIcon;
    } else {
      icon = _icons[
          (_icons.indexOf(_thirdIcon) + index + 1) %
              _icons.length];
    }

    return GestureDetector(
      onTap: () => _selectAnswer(index),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(22),

          border: Border.all(
            color: borderColor,
            width: 4,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Icon(
          icon,
          size: 50,
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    final correct =
        _selectedAnswer == _correctAnswer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: correct
            ? Colors.green.shade100
            : Colors.red.shade100,

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          // MENSAGEM
          Row(
            children: [

              Icon(
                correct
                    ? Icons.check_circle
                    : Icons.cancel,

                color:
                    correct ? Colors.green : Colors.red,

                size: 28,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  correct
                      ? 'Muito bem! Você completou o padrão! 🎉'
                      : 'Quase! Tente observar o padrão novamente. 💙',

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // BOTÕES
          Row(
            children: [

              // TENTAR NOVAMENTE
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedAnswer = null;
                    });
                  },

                  icon: const Icon(
                    Icons.refresh,
                  ),

                  label: const Text(
                    'Tentar novamente',
                  ),
                ),
              ),

              // ESPAÇO ENTRE OS BOTÕES
              if (correct)
                const SizedBox(width: 10),

              // PRÓXIMO
              if (correct)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _nextRound,

                    icon: const Icon(
                      Icons.arrow_forward,
                    ),

                    label: const Text(
                      'Próximo',
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinishedScreen() {
    final won = _lives > 0;

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

                // EMOJI
                Text(
                  won ? '🎉' : '💙',
                  style: const TextStyle(
                    fontSize: 80,
                  ),
                ),

                const SizedBox(height: 20),

                // TÍTULO
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

                // MENSAGEM
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

                // PONTUAÇÃO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(25),
                  ),

                  child: Column(
                    children: [

                      const Text(
                        'Pontuação',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 8),

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

                // JOGAR NOVAMENTE
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(
                    onPressed: _restartGame,

                    icon: const Icon(
                      Icons.refresh,
                    ),

                    label: const Text(
                      'Jogar novamente',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // VOLTAR
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                    ),

                    label: const Text(
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

class _PatternIcon extends StatelessWidget {
  final IconData icon;

  const _PatternIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,

      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Icon(
        icon,
        size: 34,
      ),
    );
  }
}