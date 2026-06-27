import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  AppGradients._();

  // Primary brand gradients
  static const LinearGradient neonPinkPurple = LinearGradient(
    colors: [AppColors.premiumPink, AppColors.neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleBlue = LinearGradient(
    colors: [AppColors.neonPurple, AppColors.royalBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGold = LinearGradient(
    colors: [AppColors.premiumPink, AppColors.accentGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Background gradients
  static const LinearGradient darkBackground = LinearGradient(
    colors: [AppColors.deepBlack, AppColors.surfaceDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient spaceBackground = LinearGradient(
    colors: [Color(0xFF0A0015), Color(0xFF080808), Color(0xFF000A1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient purplePinkBg = LinearGradient(
    colors: [Color(0xFF1A0030), Color(0xFF2D0050), Color(0xFF400030)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1.0],
  );

  // Glass gradient
  static LinearGradient glassGradient = LinearGradient(
    colors: [
      Colors.white.withValues(alpha: 0.10),
      Colors.white.withValues(alpha: 0.02),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Button gradients
  static const LinearGradient primaryButton = LinearGradient(
    colors: [AppColors.premiumPink, AppColors.neonPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient secondaryButton = LinearGradient(
    colors: [
      AppColors.neonPurple.withValues(alpha: 0.8),
      AppColors.royalBlue.withValues(alpha: 0.8),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Radial glows
  static const RadialGradient pinkGlow = RadialGradient(
    colors: [Color(0x40FF2D7A), Color(0x00FF2D7A)],
    center: Alignment.center,
    radius: 1.0,
  );

  static const RadialGradient purpleGlow = RadialGradient(
    colors: [Color(0x408B5CF6), Color(0x008B5CF6)],
    center: Alignment.center,
    radius: 1.0,
  );

  static const RadialGradient blueGlow = RadialGradient(
    colors: [Color(0x402563EB), Color(0x002563EB)],
    center: Alignment.center,
    radius: 1.0,
  );
}
