
import 'package:flutter/material.dart';

class SkillData {
  final String name;
  final String category;
  final IconData icon;
  final String level;

  const SkillData({
    required this.name,
    required this.category,
    required this.icon,
    required this.level,
  });
}

const List<SkillData> skillsData = [
  // Flutter & Mobile Development
  SkillData(
    name: 'Flutter',
    category: 'Mobile Development',
    icon: Icons.phone_android,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'Dart',
    category: 'Mobile Development',
    icon: Icons.code,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'Android App Development',
    category: 'Mobile Development',
    icon: Icons.android,
    level: 'Experience details to be updated',
  ),

  // Backend & Database
  SkillData(
    name: 'Firebase',
    category: 'Backend & Database',
    icon: Icons.local_fire_department,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'Cloud Firestore',
    category: 'Backend & Database',
    icon: Icons.storage,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'REST API',
    category: 'Backend & Database',
    icon: Icons.api,
    level: 'Experience details to be updated',
  ),

  // AI & Automation
  SkillData(
    name: 'AI Agent Development',
    category: 'AI & Automation',
    icon: Icons.smart_toy,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'n8n Workflow Automation',
    category: 'AI & Automation',
    icon: Icons.account_tree,
    level: 'Advanced',
  ),
  SkillData(
    name: 'OpenAI API',
    category: 'AI & Automation',
    icon: Icons.psychology,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'Google Gemini API',
    category: 'AI & Automation',
    icon: Icons.auto_awesome,
    level: 'Experience details to be updated',
  ),
  SkillData(
    name: 'Webhooks',
    category: 'AI & Automation',
    icon: Icons.webhook,
    level: 'Experience details to be updated',
  ),

  // Development Tools
  SkillData(
    name: 'Git & GitHub',
    category: 'Development Tools',
    icon: Icons.code_outlined,
    level: 'Experience details to be updated',
  ),
];
