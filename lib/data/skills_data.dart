import 'package:flutter/material.dart';

class SkillData {
  final String name;
  final String category;
  final IconData icon;
  final String level;
  final int? score;
  final String description;

  const SkillData({
    required this.name,
    required this.category,
    required this.icon,
    required this.level,
    required this.score,
    required this.description,
  });
}

const List<SkillData> skillsData = [
  // Mobile Development
  SkillData(
    name: 'Flutter',
    category: 'Mobile Development',
    icon: Icons.phone_android,
    level: 'Expert',
    score: 98,
    description:
        'Build responsive Android and iOS apps with smooth navigation, API and Firebase integration, and reusable components.',
  ),
  SkillData(
    name: 'Dart',
    category: 'Mobile Development',
    icon: Icons.code,
    level: 'Expert',
    score: 96,
    description:
        'Use object-oriented programming, async operations, null safety, and collections to write reliable Dart code.',
  ),
  SkillData(
    name: 'Swift (iOS Development)',
    category: 'Mobile Development',
    icon: Icons.apple,
    level: 'Learning',
    score: null,
    description:
        'Currently learning Swift and the fundamentals of native iOS application development.',
  ),

  // Backend & Database
  SkillData(
    name: 'Firebase',
    category: 'Backend & Database',
    icon: Icons.local_fire_department,
    level: 'Expert',
    score: 98,
    description:
        'Integrate Firebase Authentication, Firestore, and Storage with secure access, cloud backup, and data synchronization.',
  ),
  SkillData(
    name: 'Cloud Firestore',
    category: 'Backend & Database',
    icon: Icons.storage,
    level: 'Expert',
    score: 96,
    description:
        'Manage NoSQL collections, CRUD operations, real-time updates, Security Rules, offline data, and synchronization.',
  ),
  SkillData(
    name: 'REST API',
    category: 'Backend & Database',
    icon: Icons.api,
    level: 'Advanced',
    score: 90,
    description:
        'Connect apps to backend services using HTTP and JSON, handling tokens, responses, and API errors.',
  ),

  // AI & Automation
  SkillData(
    name: 'AI Agent Development',
    category: 'AI & Automation',
    icon: Icons.smart_toy,
    level: 'Advanced',
    score: 92,
    description:
        'Build AI agents that understand requests, generate responses, and automate tasks using models and tools.',
  ),
  SkillData(
    name: 'n8n Workflow Automation',
    category: 'AI & Automation',
    icon: Icons.account_tree,
    level: 'Advanced',
    score: 82,
    description:
        'Automate tasks in n8n by connecting apps, APIs, triggers, actions, and webhooks.',
  ),
  SkillData(
    name: 'OpenAI API',
    category: 'AI & Automation',
    icon: Icons.psychology,
    level: 'Advanced',
    score: 91,
    description:
        'Integrate OpenAI models for chat, text generation, prompt handling, and application workflows.',
  ),
  SkillData(
    name: 'Google Gemini API',
    category: 'AI & Automation',
    icon: Icons.auto_awesome,
    level: 'Advanced',
    score: 90,
    description:
        'Use Gemini API for conversational features, content generation, contextual responses, and AI-assisted tools.',
  ),
  SkillData(
    name: 'Webhooks',
    category: 'AI & Automation',
    icon: Icons.webhook,
    level: 'Advanced',
    score: 85,
    description:
        'Connect services with webhooks, process event payloads, and trigger automated workflows.',
  ),

  // Development Tools
  SkillData(
    name: 'Git & GitHub',
    category: 'Development Tools',
    icon: Icons.code_outlined,
    level: 'Advanced',
    score: 90,
    description:
        'Manage code with Git and GitHub using repositories, commits, branches, pull requests, and merges.',
  ),
];
