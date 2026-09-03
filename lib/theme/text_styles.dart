import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Estilo usado em títulos maiores.
  static final TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Estilo usado nos botões de escolha de perfil.
  static final TextStyle profileButton = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Estilo usado em subtítulos.
  static final TextStyle subtitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Estilo usado em textos menores.
  static final TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  AppTextStyles._();
}