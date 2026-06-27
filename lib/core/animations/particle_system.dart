import 'dart:math';
import 'package:flutter/material.dart';

/// Lightweight particle system for background effects
class ParticleSystem extends StatefulWidget {
  final int particleCount;
  final Color color;
  final double minSize;
  final double maxSize;
  final double speed;
  final bool glow;

  const ParticleSystem({
    super.key,
    this.particleCount = 50,
    this.color = Colors.white,
    this.minSize = 1.0,
    this.maxSize = 3.0,
    this.speed = 1.0,
    this.glow = true,
  });

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

class _ParticleSystemState extends State<ParticleSystem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<_Particle> _particles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _generateParticles();
    _controller.addListener(() => setState(() {}));
  }

  void _generateParticles() {
    _particles = List.generate(widget.particleCount, (index) {
      return _Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: widget.minSize +
            _random.nextDouble() * (widget.maxSize - widget.minSize),
        speedX: (_random.nextDouble() - 0.5) * 0.0005 * widget.speed,
        speedY: (_random.nextDouble() - 0.5) * 0.0005 * widget.speed,
        opacity: 0.2 + _random.nextDouble() * 0.6,
        phase: _random.nextDouble() * pi * 2,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return CustomPaint(
          size: Size(width, height),
          painter: _ParticlePainter(
            particles: _particles,
            progress: _controller.value,
            color: widget.color,
            glow: widget.glow,
          ),
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speedX;
  final double speedY;
  final double opacity;
  final double phase;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.phase,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;
  final bool glow;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
    required this.glow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      // Move particles
      p.x += p.speedX;
      p.y += p.speedY;

      // Wrap around
      if (p.x < 0) p.x = 1;
      if (p.x > 1) p.x = 0;
      if (p.y < 0) p.y = 1;
      if (p.y > 1) p.y = 0;

      // Twinkle effect
      final twinkle = 0.5 + 0.5 * sin(progress * 2 * pi + p.phase);
      final currentOpacity = p.opacity * twinkle;

      final dx = p.x * size.width;
      final dy = p.y * size.height;

      if (glow) {
        // Glow effect
        final glowPaint = Paint()
          ..color = color.withValues(alpha: currentOpacity * 0.2)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 3);
        canvas.drawCircle(Offset(dx, dy), p.size * 2, glowPaint);
      }

      // Main particle
      final paint = Paint()..color = color.withValues(alpha: currentOpacity);
      canvas.drawCircle(Offset(dx, dy), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

/// Particle explosion effect
class ParticleExplosion extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final VoidCallback? onComplete;

  const ParticleExplosion({
    super.key,
    required this.child,
    this.trigger = false,
    this.onComplete,
  });

  @override
  State<ParticleExplosion> createState() => _ParticleExplosionState();
}

class _ParticleExplosionState extends State<ParticleExplosion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ParticleExplosion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
