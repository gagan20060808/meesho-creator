import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class PremiumFeaturesPage extends StatelessWidget {
  const PremiumFeaturesPage({super.key});

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
                'Everything You Need',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.softWhite,
                  shadows: [
                    Shadow(
                      color: AppColors.premiumPink.withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 600))
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 8),

              Text(
                'Premium tools for premium creators',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  letterSpacing: 1,
                ),
              ).animate(delay: const Duration(milliseconds: 300)).fadeIn(),

              const SizedBox(height: 36),

              // Feature cards
              _buildFeatureCard(
                icon: Icons.storefront_rounded,
                title: 'Creator Marketplace',
                subtitle: 'Get discovered by brands worldwide',
                color: AppColors.premiumPink,
                delay: 500,
              ),
              _buildFeatureCard(
                icon: Icons.handshake_rounded,
                title: 'Brand Deals',
                subtitle: 'Exclusive partnership opportunities',
                color: AppColors.neonPurple,
                delay: 700,
              ),
              _buildFeatureCard(
                icon: Icons.analytics_rounded,
                title: 'Analytics',
                subtitle: 'Deep insights into your growth',
                color: AppColors.royalBlue,
                delay: 900,
              ),
              _buildFeatureCard(
                icon: Icons.emoji_events_rounded,
                title: 'Rewards',
                subtitle: 'Earn badges, bonuses and perks',
                color: AppColors.accentGold,
                delay: 1100,
              ),
              _buildFeatureCard(
                icon: Icons.rocket_launch_rounded,
                title: 'Exclusive Campaigns',
                subtitle: 'First access to brand campaigns',
                color: const Color(0xFF10B981),
                delay: 1300,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required int delay,
  }) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.only(bottom: 10),
      borderRadius: 16,
      borderColor: color.withValues(alpha: 0.2),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.3),
                  color.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.softWhite,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: color.withValues(alpha: 0.5),
            size: 16,
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: const Duration(milliseconds: 500))
        .slideX(begin: 0.15, end: 0);
  }
}
