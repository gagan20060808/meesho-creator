import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/widgets/floating_card.dart';

class YouTubePartnershipPage extends StatelessWidget {
  const YouTubePartnershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.purplePinkBg),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // YouTube Logo
              Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF0000).withValues(alpha: 0.4),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.play_arrow_rounded,
                      color: Colors.white, size: 48),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.0, 1.0),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(),

              const SizedBox(height: 20),

              // X connector
              Text(
                '\u00d7',
                style: TextStyle(
                  fontSize: 36,
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.w300,
                ),
              ).animate(delay: const Duration(milliseconds: 400)).fadeIn(),

              const SizedBox(height: 20),

              // Meesho Creator badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: AppGradients.neonPinkPurple,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.premiumPink.withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Text(
                  'Meesho Creator',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ).animate(delay: const Duration(milliseconds: 600)).fadeIn(
                    duration: const Duration(milliseconds: 600),
                  ).slideY(begin: 0.3, end: 0),

              const SizedBox(height: 40),

              // Title
              Text(
                'YouTube \u00d7 Meesho Creator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.softWhite,
                  shadows: [
                    Shadow(
                      color: AppColors.premiumPink.withValues(alpha: 0.3),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ).animate(delay: const Duration(milliseconds: 800)).fadeIn(),

              const SizedBox(height: 20),

              // Subtitle items
              _buildSubtitleItem('Partnerships.', AppColors.premiumPink, 1000),
              _buildSubtitleItem('Campaigns.', AppColors.neonPurple, 1200),
              _buildSubtitleItem('Monetization.', AppColors.accentGold, 1400),

              const SizedBox(height: 40),

              // Floating emoji icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _floatingEmoji('\u{1F3A5}', 0.0),
                  _floatingEmoji('\u{1F4C8}', 0.5),
                  _floatingEmoji('\u{1F4B0}', 1.0),
                  _floatingEmoji('\u{1F680}', 1.5),
                ],
              ).animate(delay: const Duration(milliseconds: 1600)).fadeIn(
                    duration: const Duration(milliseconds: 800),
                  ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitleItem(String text, Color color, int delayMs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: color,
          letterSpacing: 1.5,
        ),
      ).animate(delay: Duration(milliseconds: delayMs)).fadeIn(
            duration: const Duration(milliseconds: 500),
          ).slideX(begin: -0.2, end: 0),
    );
  }

  Widget _floatingEmoji(String emoji, double delay) {
    return FloatingCard(
      floatDistance: 12,
      duration: const Duration(milliseconds: 2500),
      delay: delay,
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}
