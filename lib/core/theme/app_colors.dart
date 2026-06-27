import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const Color deepBlack = Color(0xFF080808);
  static const Color premiumPink = Color(0xFFFF2D7A);
  static const Color neonPurple = Color(0xFF8B5CF6);
  static const Color royalBlue = Color(0xFF2563EB);
  static const Color softWhite = Color(0xFFF8FAFC);
  static const Color accentGold = Color(0xFFF9C74F);

  // Extended palette
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceCard = Color(0xFF1A1A2E);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Neon with opacity variants
  static Color pinkGlow = premiumPink.withValues(alpha: 0.4);
  static Color purpleGlow = neonPurple.withValues(alpha: 0.4);
  static Color blueGlow = royalBlue.withValues(alpha: 0.3);
  static Color goldGlow = accentGold.withValues(alpha: 0.3);

  // Glass colors
  static Color glassWhite = Colors.white.withValues(alpha: 0.06);
  static Color glassBorder = Colors.white.withValues(alpha: 0.12);
  static Color glassWhiteStrong = Colors.white.withValues(alpha: 0.10);
}
