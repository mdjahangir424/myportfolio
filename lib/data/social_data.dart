
import 'package:flutter/material.dart';

class SocialData {
  final String name;
  final IconData icon;
  final String url;

  const SocialData({
    required this.name,
    required this.icon,
    required this.url,
  });
}

const List<SocialData> socialData = [
  SocialData(
    name: 'Facebook',
    icon: Icons.facebook,
    url: 'https://www.facebook.com/share/1CJhQgE22q/',
  ),
  SocialData(
    name: 'GitHub',
    icon: Icons.code,
    url: 'https://github.com/mdjahangir424',
  ),
  SocialData(
    name: 'LinkedIn',
    icon: Icons.business_center_outlined,
    url: 'https://www.linkedin.com/in/mdjahangir424?utm_source=share_via&utm_content=profile&utm_medium=member_android',
  ),
  SocialData(
    name: 'YouTube',
    icon: Icons.play_circle_outline,
    url: 'https://youtube.com/@voiceofjahangiralam?si=OzLaQ7OFWfDBes0H',
  ),
  SocialData(
    name: 'Email',
    icon: Icons.email_outlined,
    url: 'mailto:mdjahangir424@outlook.com',
  ),
  SocialData(
    name: 'WhatsApp',
    icon: Icons.chat_outlined,
    url: 'https://wa.me/8801778600028',
  ),
];