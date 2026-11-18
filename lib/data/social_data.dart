
import 'package:flutter/material.dart';

class SocialData {
  final String name;
  final IconData icon;

  const SocialData({
    required this.name,
    required this.icon,
  });
}

const List<SocialData> socialData = [
  SocialData(
    name: 'Facebook',
    icon: Icons.facebook,
  ),
  SocialData(
    name: 'GitHub',
    icon: Icons.code,
  ),
  SocialData(
    name: 'LinkedIn',
    icon: Icons.business_center_outlined,
  ),
  SocialData(
    name: 'YouTube',
    icon: Icons.play_circle_outline,
  ),
  SocialData(
    name: 'Email',
    icon: Icons.email_outlined,
  ),
];
