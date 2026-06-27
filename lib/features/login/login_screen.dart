import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/animations/particle_system.dart';
import '../../core/widgets/glow_button.dart';
import '../../core/widgets/glass_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _obscurePassword = true;

  late final AnimationController _orbController;
  late final Animation<double> _orbAnimation1;
  late final Animation<double> _orbAnimation2;

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat(reverse: true);
    _orbAnimation1 = Tween<double>(begin: 0.0, end: 30.0).animate(
      CurvedAnimation(parent: _orbController, curve: Curves.easeInOut),
    );
    _orbAnimation2 = Tween<double>(begin: 0.0, end: -20.0).animate(
      CurvedAnimation(parent: _orbController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _orbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.deepBlack,
      body: Stack(
        children: [
          // Background particles
          const ParticleSystem(
            particleCount: 30,
            color: AppColors.neonPurple,
            minSize: 0.3,
            maxSize: 1.5,
            speed: 0.3,
          ),

          // Floating gradient orbs
          AnimatedBuilder(
            animation: _orbController,
            builder: (context, child) {
              return Stack(
                children: [
                  // Pink orb
                  Positioned(
                    top: height * 0.05 + _orbAnimation1.value,
                    left: -40,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.premiumPink.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Purple orb
                  Positioned(
                    top: height * 0.3 + _orbAnimation2.value,
                    right: -60,
                    child: Container(
                      width: 250,
                      height: 250,
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
                  // Blue orb
                  Positioned(
                    bottom: height * 0.1 + _orbAnimation1.value,
                    left: height * 0.1,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.royalBlue.withValues(alpha: 0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Back arrow
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.glassWhite,
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.softWhite,
                        size: 18,
                      ),
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2, end: 0),

                  const SizedBox(height: 32),

                  // Title
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softWhite,
                      shadows: [
                        Shadow(
                          color: AppColors.premiumPink.withValues(alpha: 0.3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ).animate(delay: const Duration(milliseconds: 200)).fadeIn(
                        duration: const Duration(milliseconds: 600),
                      ).slideY(begin: 0.15, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    'Sign in to continue your creator journey',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ).animate(delay: const Duration(milliseconds: 400)).fadeIn(),

                  const SizedBox(height: 36),

                  // Email field
                  _buildGlassInput(
                    controller: _emailController,
                    hintText: 'Email Address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    delay: 600,
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  _buildGlassInput(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline_rounded,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textMuted,
                        size: 20,
                      ),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    delay: 700,
                  ),

                  const SizedBox(height: 16),

                  // Phone number field
                  _buildGlassInput(
                    controller: _phoneController,
                    hintText: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    prefix: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '+91',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    delay: 800,
                  ),

                  const SizedBox(height: 16),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => HapticFeedback.lightImpact(),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.neonPurple,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: AppColors.neonPurple.withValues(alpha: 0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate(delay: const Duration(milliseconds: 900)).fadeIn(),

                  const SizedBox(height: 28),

                  // Sign In button
                  GlowButton(
                    text: 'Sign In',
                    icon: Icons.login_rounded,
                    onTap: () => HapticFeedback.mediumImpact(),
                  ).animate(delay: const Duration(milliseconds: 1000)).fadeIn(
                        duration: const Duration(milliseconds: 500),
                      ).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.glassBorder,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.glassBorder,
                        ),
                      ),
                    ],
                  ).animate(delay: const Duration(milliseconds: 1100)).fadeIn(),

                  const SizedBox(height: 24),

                  // Social login buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          label: 'Google',
                          icon: Icons.g_mobiledata_rounded,
                          color: const Color(0xFF4285F4),
                          onTap: () => HapticFeedback.lightImpact(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSocialButton(
                          label: 'YouTube',
                          icon: Icons.play_circle_fill_rounded,
                          color: const Color(0xFFFF0000),
                          onTap: () => HapticFeedback.lightImpact(),
                        ),
                      ),
                    ],
                  ).animate(delay: const Duration(milliseconds: 1200)).fadeIn(
                        duration: const Duration(milliseconds: 500),
                      ).slideY(begin: 0.15, end: 0),

                  const SizedBox(height: 32),

                  // Create Account
                  Center(
                    child: GestureDetector(
                      onTap: () => HapticFeedback.lightImpact(),
                      child: GlowButton(
                        text: 'Create Account',
                        outlined: true,
                        glowColor: AppColors.neonPurple.withValues(alpha: 0.3),
                        onTap: () => HapticFeedback.lightImpact(),
                      ),
                    ),
                  ).animate(delay: const Duration(milliseconds: 1400)).fadeIn(
                        duration: const Duration(milliseconds: 500),
                      ).slideY(begin: 0.15, end: 0),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    Widget? prefix,
    int delay = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.glassWhite,
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          color: AppColors.softWhite,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
          prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
          prefix: prefix,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.glassWhite,
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.softWhite,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
