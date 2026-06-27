import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/animations/particle_system.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.spaceBackground),
      child: Stack(
        children: [
          // Neon particles
          const ParticleSystem(
            particleCount: 40,
            color: AppColors.neonPurple,
            minSize: 0.5,
            maxSize: 2.5,
            speed: 0.4,
          ),

          // Ambient glow orbs
          Positioned(
            top: height * 0.1,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.neonPurple.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.2,
            right: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.premiumPink.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // 3D Floating phone mockup
                  _buildPhoneMockup()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .translateY(
                        begin: -10,
                        end: 10,
                        duration: const Duration(milliseconds: 3000),
                        curve: Curves.easeInOut,
                      ),

                  const SizedBox(height: 60),

                  // Title
                  Text(
                    'Welcome to\nMeesho Creator',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softWhite,
                      height: 1.3,
                      shadows: [
                        Shadow(
                          color: AppColors.neonPurple.withValues(alpha: 0.3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOut,
                      ).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Subtitle
                  Column(
                    children: [
                      _subtitleWord('Create.', AppColors.premiumPink, 0),
                      _subtitleWord('Grow.', AppColors.neonPurple, 200),
                      _subtitleWord('Earn.', AppColors.royalBlue, 400),
                      _subtitleWord('Inspire.', AppColors.accentGold, 600),
                    ],
                  ),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subtitleWord(String word, Color color, int delayMs) {
    return Text(
      word,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 2,
      ),
    ).animate(delay: Duration(milliseconds: 800 + delayMs)).fadeIn(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        ).slideX(begin: -0.3, end: 0);
  }

  Widget _buildPhoneMockup() {
    return Container(
      width: 180,
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            AppColors.glassWhiteStrong,
            AppColors.glassWhite,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          // Notch
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.glassBorder,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 20),
          // Mock content
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.glassWhite,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.premiumPink.withValues(alpha: 0.2),
                  AppColors.neonPurple.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (i) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.glassWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
