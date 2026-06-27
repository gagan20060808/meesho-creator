import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/animations/particle_system.dart';
import '../../../core/animations/transition_builders.dart';
import '../../../core/widgets/glow_button.dart';
import '../../login/login_screen.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> with TickerProviderStateMixin {
  bool _exploding = false;

  late final AnimationController _explosionController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _explosionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 3.0).animate(
      CurvedAnimation(parent: _explosionController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _explosionController, curve: Curves.easeOut),
    );
    _explosionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          PremiumPageRoute(
            page: const LoginScreen(),
            transitionType: PremiumTransitionType.blurReveal,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _explosionController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    HapticFeedback.heavyImpact();
    setState(() => _exploding = true);
    _explosionController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.spaceBackground),
      child: Stack(
        children: [
          // Particles
          const ParticleSystem(
            particleCount: 50,
            color: AppColors.premiumPink,
            minSize: 0.5,
            maxSize: 2.5,
            speed: 0.6,
          ),

          // Ambient glow
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.neonPurple.withValues(alpha: 0.15),
                    AppColors.premiumPink.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.2, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: AnimatedBuilder(
              animation: _explosionController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _exploding ? _scaleAnimation.value : 1.0,
                  child: Opacity(
                    opacity: _exploding ? _opacityAnimation.value : 1.0,
                    child: child,
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // 3D Merged Logo
                    _buildMergedLogo()
                        .animate()
                        .scale(
                          begin: const Offset(0.3, 0.3),
                          end: const Offset(1.0, 1.0),
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.elasticOut,
                        )
                        .fadeIn(),

                    const SizedBox(height: 40),

                    // Title
                    Text(
                      'The Future of\nCreator Commerce',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.softWhite,
                        height: 1.3,
                        shadows: [
                          Shadow(
                            color:
                                AppColors.premiumPink.withValues(alpha: 0.4),
                            blurRadius: 25,
                          ),
                          Shadow(
                            color:
                                AppColors.neonPurple.withValues(alpha: 0.2),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                    )
                        .animate(delay: const Duration(milliseconds: 400))
                        .fadeIn(duration: const Duration(milliseconds: 800))
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 12),

                    Text(
                      'Begins Here.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: AppColors.accentGold,
                        letterSpacing: 3,
                      ),
                    )
                        .animate(delay: const Duration(milliseconds: 800))
                        .fadeIn(duration: const Duration(milliseconds: 600)),

                    const SizedBox(height: 50),

                    // Get Started button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: GlowButton(
                        text: 'Get Started',
                        icon: Icons.rocket_launch_rounded,
                        height: 60,
                        onTap: _onGetStarted,
                      ),
                    )
                        .animate(delay: const Duration(milliseconds: 1200))
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                        )
                        .slideY(begin: 0.3, end: 0),

                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ),

          // Explosion particles (shown during transition)
          if (_exploding)
            Center(
              child: AnimatedBuilder(
                animation: _explosionController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value * 2,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.premiumPink
                                  .withValues(alpha: 0.6),
                              AppColors.neonPurple
                                  .withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMergedLogo() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.premiumPink.withValues(alpha: 0.2),
            AppColors.neonPurple.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.neonPurple.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.premiumPink.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: AppColors.neonPurple.withValues(alpha: 0.2),
            blurRadius: 60,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // YouTube play icon
          Container(
            width: 60,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFFF0000),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF0000).withValues(alpha: 0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 28),
            ),
          ),
          // "M" overlay
          Positioned(
            bottom: 20,
            child: Text(
              'MC',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.softWhite,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: AppColors.neonPurple.withValues(alpha: 0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
