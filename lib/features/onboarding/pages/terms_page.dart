import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glow_button.dart';
import '../../../core/widgets/glass_card.dart';

class TermsPage extends StatefulWidget {
  final PageController? pageController;
  const TermsPage({super.key, this.pageController});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> with TickerProviderStateMixin {
  bool _accepted = false;
  bool _showSignature = false;

  late final AnimationController _signatureController;
  late final Animation<double> _signatureProgress;

  @override
  void initState() {
    super.initState();
    _signatureController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _signatureProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _signatureController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  void _onAccept() {
    HapticFeedback.mediumImpact();
    setState(() {
      _accepted = true;
      _showSignature = true;
    });
    _signatureController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepBlack,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Header
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.softWhite,
                  shadows: [
                    Shadow(
                      color: AppColors.neonPurple.withValues(alpha: 0.3),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: const Duration(milliseconds: 600)),

              const SizedBox(height: 8),

              Text(
                'Please review and accept to continue',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ).animate(delay: const Duration(milliseconds: 200)).fadeIn(),

              const SizedBox(height: 32),

              // Animated contract card
              GlassCard(
                padding: const EdgeInsets.all(24),
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contractLine('Creator Agreement', 16, FontWeight.bold,
                        AppColors.softWhite, 400),
                    const SizedBox(height: 16),
                    _contractLine(
                        'By using Meesho Creator, you agree to:',
                        13,
                        FontWeight.normal,
                        AppColors.textSecondary,
                        600),
                    const SizedBox(height: 12),
                    _contractBullet(
                        'Fair usage and content policies', 800),
                    _contractBullet(
                        'Creator monetization guidelines', 1000),
                    _contractBullet(
                        'Community standards & respect', 1200),
                    _contractBullet(
                        'Data privacy & security terms', 1400),
                    _contractBullet(
                        'Brand partnership agreements', 1600),

                    const SizedBox(height: 24),

                    // Checkbox
                    GestureDetector(
                      onTap: _accepted ? null : _onAccept,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.elasticOut,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _accepted
                              ? AppColors.neonPurple.withValues(alpha: 0.15)
                              : AppColors.glassWhite,
                          border: Border.all(
                            color: _accepted
                                ? AppColors.neonPurple
                                : AppColors.glassBorder,
                            width: _accepted ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: _accepted
                                    ? AppColors.neonPurple
                                    : Colors.transparent,
                                border: Border.all(
                                  color: _accepted
                                      ? AppColors.neonPurple
                                      : AppColors.textMuted,
                                  width: 2,
                                ),
                              ),
                              child: _accepted
                                  ? const Icon(Icons.check,
                                      color: Colors.white, size: 16)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'I accept all terms and conditions',
                                style: TextStyle(
                                  color: _accepted
                                      ? AppColors.softWhite
                                      : AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate(delay: const Duration(milliseconds: 1800))
                        .fadeIn(),

                    // Signature area
                    if (_showSignature) ...[
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Digital Signature',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _signatureProgress,
                            builder: (context, child) {
                              return CustomPaint(
                                size: const Size(double.infinity, 40),
                                painter: _SignaturePainter(
                                  progress: _signatureProgress.value,
                                  color: AppColors.neonPurple,
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 1,
                            color: AppColors.glassBorder,
                          ),
                        ],
                      ).animate().fadeIn(),
                    ],
                  ],
                ),
              ).animate(delay: const Duration(milliseconds: 300)).fadeIn(
                    duration: const Duration(milliseconds: 800),
                  ).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 32),

              // Accept button
              if (_accepted)
                GlowButton(
                  text: 'Accept & Continue',
                  icon: Icons.arrow_forward_rounded,
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    widget.pageController?.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                ).animate().fadeIn(
                      duration: const Duration(milliseconds: 600),
                    ).slideY(begin: 0.3, end: 0),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contractLine(
      String text, double size, FontWeight weight, Color color, int delayMs) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    ).animate(delay: Duration(milliseconds: delayMs)).fadeIn(
          duration: const Duration(milliseconds: 400),
        );
  }

  Widget _contractBullet(String text, int delayMs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.premiumPink.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ).animate(delay: Duration(milliseconds: delayMs)).fadeIn(
            duration: const Duration(milliseconds: 400),
          ).slideX(begin: -0.1, end: 0),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  final double progress;
  final Color color;

  _SignaturePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = [
      Offset(size.width * 0.0, size.height * 0.8),
      Offset(size.width * 0.1, size.height * 0.3),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.35, size.height * 0.2),
      Offset(size.width * 0.45, size.height * 0.7),
      Offset(size.width * 0.55, size.height * 0.4),
      Offset(size.width * 0.65, size.height * 0.6),
      Offset(size.width * 0.75, size.height * 0.3),
      Offset(size.width * 0.85, size.height * 0.5),
      Offset(size.width * 0.95, size.height * 0.4),
    ];

    final totalPoints = (points.length * progress).toInt();
    if (totalPoints < 2) return;

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < totalPoints && i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      path.quadraticBezierTo(
        prev.dx,
        prev.dy,
        (prev.dx + curr.dx) / 2,
        (prev.dy + curr.dy) / 2,
      );
    }

    canvas.drawPath(path, paint);

    // Glow effect
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
