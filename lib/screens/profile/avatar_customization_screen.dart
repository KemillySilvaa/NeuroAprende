import 'package:flutter/material.dart';

import '../../services/progress_service.dart';
import '../../theme/app_colors.dart';

class AvatarCustomizationScreen extends StatefulWidget {
  const AvatarCustomizationScreen({super.key});

  @override
  State<AvatarCustomizationScreen> createState() =>
      _AvatarCustomizationScreenState();
}

class _AvatarCustomizationScreenState
    extends State<AvatarCustomizationScreen> {
  int selectedAvatar = 0;
  int selectedColor = 0;

  final List<IconData> avatars = [
    Icons.face,
    Icons.face_3,
    Icons.face_4,
    Icons.face_6,
  ];

  final List<Color> colors = [
    AppColors.blue,
    AppColors.green,
    AppColors.yellow,
    const Color(0xFFD7C5FF),
  ];

void _saveAvatar() {
  ProgressService.saveAvatar(
    avatar: avatars[selectedAvatar],
    color: colors[selectedColor],
  );

  Navigator.pop(context, true);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Personalizar avatar',
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

              const Text(
                'Crie seu avatar! 🎨',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Escolha o personagem que mais combina com você.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              // AVATAR
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),

                width: 180,
                height: 180,

                decoration: BoxDecoration(
                  color: colors[selectedColor],
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),

                child: Icon(
                  avatars[selectedAvatar],
                  size: 110,
                ),
              ),

              const SizedBox(height: 35),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Escolha seu personagem',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: List.generate(
                  avatars.length,
                  (index) {
                    final selected =
                        selectedAvatar == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = index;
                        });
                      },

                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 200),

                        width: 70,
                        height: 70,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: selected
                                ? AppColors.blue
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),

                        child: Icon(
                          avatars[index],
                          size: 38,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 35),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Escolha uma cor',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: List.generate(
                  colors.length,
                  (index) {
                    final selected =
                        selectedColor == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },

                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 200),

                        width: 65,
                        height: 65,

                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: selected
                                ? Colors.black
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),

                        child: selected
                            ? const Icon(
                                Icons.check,
                                size: 30,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton.icon(
                  onPressed: _saveAvatar,

                  icon: const Icon(
                    Icons.check,
                  ),

                  label: const Text(
                    'Salvar avatar',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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
}