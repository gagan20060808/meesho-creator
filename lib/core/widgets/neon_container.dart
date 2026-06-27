import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Container with animated neon border glow
class NeonContainer extends StatefulWidget {
  final Widget child;
  final Color? glowColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;

  const NeonContainer({
    super.key,
    required this.child,
    this.glowColor,
    this.borderRadius = 20,
    this.borderWidth = 1.5,
    this.padding,
  });

  @override
  State<NeonContainer> createState() => _NeonContainerState();
}

class _NeonContainerState extends State<NeonContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.glowColor ?? AppColors.neonPurple;
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          padding: widget.padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: color.withValues(alpha: _glowAnimation.value),
              width: widget.borderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.3),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.1),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
