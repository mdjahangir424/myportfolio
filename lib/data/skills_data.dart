
import 'package:flutter/material.dart';

class SkillData {
  final String name;
  final String category;
  final String level;
  final IconData icon;

  const SkillData({
    required this.name,
    required this.category,
    required this.level,
    required this.icon,
  });
}

const List<SkillData> skillsData = [
  // Flutter Development
  SkillData(
    name: 'Flutter',
    category: 'Mobile Development',
    level: 'Advanced',
    icon: Icons.phone_android,
  ),
  SkillData(
    name: 'Dart',
    category: 'Mobile Development',
    level: 'Intermediate',
    icon: Icons.code,
  ),
  SkillData(
    name: 'Android Development',
    category: 'Mobile Development',
    level: 'Intermediate',
    icon: Icons.android,
  ),

  // Backend & Database
  SkillData(
    name: 'Firebase',
    category: 'Backend & Database',
    level: 'Intermediate',
    icon: Icons.local_fire_department,
  ),
  SkillData(
    name: 'Cloud Firestore',
    category: 'Backend & Database',
    level: 'Intermediate',
    icon: Icons.cloud,
  ),
  SkillData(
    name: 'GitHub',
    category: 'Backend & Database',
    level: 'Intermediate',
    icon: Icons.code,
  ),

  // AI & Automation
  SkillData(
    name: 'AI Agent Development',
    category: 'AI & Automation',
    level: 'Intermediate',
    icon: Icons.smart_toy,
  ),
  SkillData(
    name: 'AI Automation',
    category: 'AI & Automation',
    level: 'Intermediate',
    icon: Icons.auto_awesome,
  ),
  SkillData(
    name: 'Workflow Automation',
    category: 'AI & Automation',
    level: 'Intermediate',
    icon: Icons.account_tree,
  ),
];
