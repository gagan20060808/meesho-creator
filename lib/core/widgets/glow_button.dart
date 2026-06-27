import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';

/// Premium glow button with neon border, ripple, and 3D press animation
class GlowButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final IconData? icon;
  final double width;
  final double height;
  final double borderRadius;
  final bool outlined;
  final Color? glowColor;
  final TextStyle? textStyle;

  const GlowButton({
    super.key,
    required this.text,
    this.onTap,
    this.gradient,
    this.icon,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 16,
    this.outlined = false,
    this.glowColor,
    this.textStyle,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    setState(() => _isPressed = false);
    HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor =
        widget.glowColor ?? AppColors.premiumPink.withValues(alpha: 0.4);
    final effectiveGradient =
        widget.gradient ?? AppGradients.primaryButton;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: widget.outlined ? null : effectiveGradient,
            border: widget.outlined
                ? Border.all(color: AppColors.neonPurple, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: effectiveGlowColor,
                blurRadius: _isPressed ? 8 : 20,
                spreadRadius: _isPressed ? 0 : 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: effectiveGlowColor.withValues(alpha: 0.2),
                blurRadius: _isPressed ? 4 : 40,
                spreadRadius: _isPressed ? -2 : -4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              onTap: widget.onTap,
              splashColor: Colors.white.withValues(alpha: 0.1),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: AppColors.softWhite, size: 20),
                      const SizedBox(width: 10),
                    ],
                    Text(
                      widget.text,
                      style: widget.textStyle ??
                          TextStyle(
                            color: widget.outlined
                                ? AppColors.softWhite
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
