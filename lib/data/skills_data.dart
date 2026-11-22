
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
    level: 'Not specified',
  ),
  SkillData(
    name: 'Dart',
    category: 'Mobile Development',
    icon: Icons.code,
    level: 'Not specified',
  ),
  SkillData(
    name: 'Android App Development',
    category: 'Mobile Development',
    icon: Icons.android,
    level: 'Not specified',
  ),

  // Backend & Database
  SkillData(
    name: 'Firebase',
    category: 'Backend & Database',
    icon: Icons.local_fire_department,
    level: 'Not specified',
  ),
  SkillData(
    name: 'Cloud Firestore',
    category: 'Backend & Database',
    icon: Icons.storage,
    level: 'Not specified',
  ),
  SkillData(
    name: 'REST API',
    category: 'Backend & Database',
    icon: Icons.api,
    level: 'Not specified',
  ),

  // AI & Automation
  SkillData(
    name: 'AI Agent Development',
    category: 'AI & Automation',
    icon: Icons.smart_toy,
    level: 'Not specified',
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
    level: 'Not specified',
  ),
  SkillData(
    name: 'Google Gemini API',
    category: 'AI & Automation',
    icon: Icons.auto_awesome,
    level: 'Not specified',
  ),
  SkillData(
    name: 'Webhooks',
    category: 'AI & Automation',
    icon: Icons.webhook,
    level: 'Not specified',
  ),

  // Development Tools
  SkillData(
    name: 'Git & GitHub',
    category: 'Development Tools',
    icon: Icons.code_outlined,
    level: 'Not specified',
  ),
];
