import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    required this.onFinished,
    super.key,
    this.duration = const Duration(seconds: 2),
    this.title = 'Welcome',
    this.subtitle = 'Preparing your experience',
    this.logo,
  });

  final Duration duration;
  final String title;
  final String subtitle;
  final Widget? logo;
  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, () {
      if (mounted) {
        widget.onFinished();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.logo ??
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 56,
                      ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
