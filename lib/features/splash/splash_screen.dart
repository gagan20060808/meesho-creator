import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/animations/particle_system.dart';
import '../../core/animations/liquid_reveal.dart';
import '../../core/animations/transition_builders.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _circleController;
  late final AnimationController _textController;
  late final AnimationController _logoController;
  late final AnimationController _taglineController;

  late final Animation<double> _circleScale;
  late final Animation<double> _circleOpacity;
  late final Animation<double> _textReveal;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startSequence();
  }

  void _initAnimations() {
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _circleScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOutCubic),
    );
    _circleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _circleController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _textReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutQuart),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeInOut),
    );
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    await _circleController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    await _textController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    await _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    await _taglineController.forward();

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      PremiumPageRoute(
        page: const OnboardingScreen(),
        transitionType: PremiumTransitionType.blurReveal,
      ),
    );
  }

  @override
  void dispose() {
    _circleController.dispose();
    _textController.dispose();
    _logoController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlack,
      body: Stack(
        children: [
          // Particle background
          const ParticleSystem(
            particleCount: 60,
            color: Color(0xFF8B5CF6),
            minSize: 0.5,
            maxSize: 2.0,
            speed: 0.5,
            glow: true,
          ),

          // Neon circle
          Center(
            child: AnimatedBuilder(
              animation: _circleController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _circleScale.value,
                  child: Opacity(
                    opacity: _circleOpacity.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.neonPurple.withValues(alpha: 0.6),
                            AppColors.premiumPink.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                          stops: const [0.3, 0.6, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonPurple.withValues(alpha: 0.5),
                            blurRadius: 60,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Pulse ring
          Center(
            child: PulseAnimation(
              duration: const Duration(milliseconds: 2000),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.neonPurple.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // "Meesho Creator" text with liquid reveal
                AnimatedBuilder(
                  animation: _textReveal,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: LiquidRevealClipper(_textReveal.value),
                      child: child,
                    );
                  },
                  child: Text(
                    'Meesho Creator',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softWhite,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: AppColors.premiumPink.withValues(alpha: 0.5),
                          blurRadius: 20,
                        ),
                        Shadow(
                          color: AppColors.neonPurple.withValues(alpha: 0.3),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // YouTube logo formed from particles
                AnimatedBuilder(
                  animation: _logoOpacity,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoOpacity.value,
                      child: child,
                    );
                  },
                  child: _buildYouTubeLogo(),
                ),

                const SizedBox(height: 40),

                // Tagline
                AnimatedBuilder(
                  animation: _taglineOpacity,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _taglineOpacity.value,
                      child: child,
                    );
                  },
                  child: Text(
                    "Powering India's Next Generation Creators",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate(delay: const Duration(milliseconds: 200))
                   .then()
                   .shimmer(
                     duration: const Duration(milliseconds: 1500),
                     color: AppColors.neonPurple.withValues(alpha: 0.3),
                   ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYouTubeLogo() {
    return Container(
      width: 80,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFFF0000),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF0000).withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}
