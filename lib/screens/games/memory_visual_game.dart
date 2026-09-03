import 'dart:math';

import 'package:flutter/material.dart';

import '../../services/progress_service.dart';
import '../../theme/app_colors.dart';

class MemoryVisualGame extends StatefulWidget {
  const MemoryVisualGame({super.key});

  @override
  State<MemoryVisualGame> createState() =>
      _MemoryVisualGameState();
}

class _MemoryVisualGameState
    extends State<MemoryVisualGame> {
  final Random _random = Random();

  final List<IconData> _symbols = [
    Icons.star,
    Icons.favorite,
    Icons.pets,
    Icons.rocket_launch,
  ];

  late List<IconData> _cards;

  final List<int> _openedCards = [];
  final Set<int> _matchedCards = {};

  int _lives = 3;
  int _xp = 0;

  bool _checking = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _createCards();
  }

  void _createCards() {
    _cards = [
      ..._symbols,
      ..._symbols,
    ];

    _cards.shuffle(_random);
  }

  void _selectCard(int index) {
    if (_checking ||
        _openedCards.contains(index) ||
        _matchedCards.contains(index)) {
      return;
    }

    setState(() {
      _openedCards.add(index);
    });

    if (_openedCards.length == 2) {
      _checkPair();
    }
  }

  Future<void> _checkPair() async {
    setState(() {
      _checking = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    final first = _openedCards[0];
    final second = _openedCards[1];

    if (_cards[first] == _cards[second]) {
      setState(() {
        _matchedCards.add(first);
        _matchedCards.add(second);

        _openedCards.clear();

        _xp += 10;

        _checking = false;
      });

      if (_matchedCards.length == _cards.length) {
        _finishGame();
      }
    } else {
      setState(() {
        _openedCards.clear();
        _lives--;
        _checking = false;
      });

      if (_lives <= 0) {
        setState(() {
          _finished = true;
        });
      }
    }
  }

  void _finishGame() {
    ProgressService.addXp(_xp);
    ProgressService.completeActivity();

    setState(() {
      _finished = true;
    });
  }

  void _restartGame() {
    setState(() {
      _openedCards.clear();
      _matchedCards.clear();

      _lives = 3;
      _xp = 0;

      _checking = false;
      _finished = false;

      _createCards();
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
          'Memória Visual',
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

              const SizedBox(height: 25),

              const Text(
                'Encontre os pares! 🧠',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Toque em duas cartas e tente encontrar figuras iguais.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              // CARTAS
              Expanded(
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),

                  itemCount: _cards.length,

                  itemBuilder: (context, index) {
                    final isOpen =
                        _openedCards.contains(index);

                    final isMatched =
                        _matchedCards.contains(index);

                    return GestureDetector(
                      onTap: () => _selectCard(index),

                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 250),

                        decoration: BoxDecoration(
                          color: isOpen || isMatched
                              ? Colors.white
                              : AppColors.blue,

                          borderRadius:
                              BorderRadius.circular(25),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.08),
                              blurRadius: 8,
                              offset:
                                  const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Center(
                          child: AnimatedSwitcher(
                            duration:
                                const Duration(milliseconds: 250),

                            child: isOpen || isMatched
                                ? Icon(
                                    _cards[index],
                                    key: ValueKey(
                                      '$index-open',
                                    ),
                                    size: 55,
                                  )
                                : const Icon(
                                    Icons.question_mark,
                                    key: ValueKey(
                                      'closed',
                                    ),
                                    size: 45,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              Text(
                '${_matchedCards.length ~/ 2} de ${_symbols.length} pares encontrados',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinishedScreen() {
    final won =
        _matchedCards.length == _cards.length;

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
                      ? 'Memória incrível!'
                      : 'Quase lá!',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  won
                      ? 'Você encontrou todos os pares!'
                      : 'Não desista! Tente novamente.',
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