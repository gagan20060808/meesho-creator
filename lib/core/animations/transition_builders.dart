import 'package:flutter/material.dart';

/// Spring animation helper for bouncy transitions
class SpringAnimations {
  SpringAnimations._();

  static const Curve bouncy = Cubic(0.34, 1.56, 0.64, 1.0);
  static const Curve smoothSpring = Cubic(0.25, 0.1, 0.25, 1.0);
  static const Curve softBounce = Cubic(0.5, 1.5, 0.5, 1.0);
  static const Curve gentleSpring = Cubic(0.175, 0.885, 0.32, 1.275);
}

/// Custom page route with premium transitions
class PremiumPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final PremiumTransitionType transitionType;

  PremiumPageRoute({
    required this.page,
    this.transitionType = PremiumTransitionType.liquidMorph,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case PremiumTransitionType.liquidMorph:
                return _liquidMorphTransition(
                    animation, secondaryAnimation, child);
              case PremiumTransitionType.slideBlur:
                return _slideBlurTransition(
                    animation, secondaryAnimation, child);
              case PremiumTransitionType.scaleFade:
                return _scaleFadeTransition(
                    animation, secondaryAnimation, child);
              case PremiumTransitionType.blurReveal:
                return _blurRevealTransition(
                    animation, secondaryAnimation, child);
            }
          },
        );

  static Widget _liquidMorphTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: SpringAnimations.smoothSpring,
    );
    return ScaleTransition(
      scale: Tween<double>(begin: 0.85, end: 1.0).animate(curved),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curved),
        child: child,
      ),
    );
  }

  static Widget _slideBlurTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(curved),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curved),
        child: child,
      ),
    );
  }

  static Widget _scaleFadeTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: SpringAnimations.gentleSpring,
    );
    return ScaleTransition(
      scale: Tween<double>(begin: 0.6, end: 1.0).animate(curved),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curved),
        child: child,
      ),
    );
  }

  static Widget _blurRevealTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutQuart,
    );
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curved),
      child: child,
    );
  }
}

enum PremiumTransitionType {
  liquidMorph,
  slideBlur,
  scaleFade,
  blurReveal,
}
