import 'package:flutter/material.dart';

@immutable
class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    this.icon = Icons.auto_awesome_rounded,
    this.child,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget? child;
}
