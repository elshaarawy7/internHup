import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/images_app.dart';
import 'package:intern_hup/core/helper/app_router.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _startSplash();
  }

  Future<void> _startSplash() async {
    // تشغيل الـ Animation
    await _controller.forward();

    // وقت بسيط بعد انتهاء الـ Animation
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    context.go(AppRouter.onBordingRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            ImagesApp.splashImage,
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}