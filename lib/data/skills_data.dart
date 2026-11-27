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
  // Mobile Development — 5 skills
  SkillData(
    name: 'Flutter',
    category: 'Mobile Development',
    icon: Icons.phone_android,
    level: 'Expert',
    score: 98,
    description: 'Build cross-platform Android and iOS apps with responsive layouts, navigation, and reusable components.',
  ),
  SkillData(
    name: 'Dart',
    category: 'Mobile Development',
    icon: Icons.code,
    level: 'Expert',
    score: 96,
    description: 'Write reliable application logic using OOP, async programming, null safety, and collections.',
  ),
  SkillData(
    name: 'Android Kotlin',
    category: 'Mobile Development',
    icon: Icons.android,
    level: 'Intermediate',
    score: 82,
    description: 'Work with native Android development concepts using Kotlin alongside cross-platform Flutter development.',
  ),
  SkillData(
    name: 'State Management',
    category: 'Mobile Development',
    icon: Icons.account_tree,
    level: 'Advanced',
    score: 88,
    description: 'Organize application state and manage data flow across screens and reusable widgets.',
  ),
  SkillData(
    name: 'Responsive UI Design',
    category: 'Mobile Development',
    icon: Icons.devices,
    level: 'Advanced',
    score: 92,
    description: 'Create adaptive interfaces that work across different screen sizes and device orientations.',
  ),

  // Backend & Database — 5 skills
  SkillData(
    name: 'Firebase',
    category: 'Backend & Database',
    icon: Icons.local_fire_department,
    level: 'Expert',
    score: 98,
    description: 'Integrate Firebase services for authentication, databases, storage, backup, and synchronization.',
  ),
  SkillData(
    name: 'Cloud Firestore',
    category: 'Backend & Database',
    icon: Icons.storage,
    level: 'Expert',
    score: 96,
    description: 'Manage NoSQL data, real-time updates, CRUD operations, offline support, and Security Rules.',
  ),
  SkillData(
    name: 'REST API',
    category: 'Backend & Database',
    icon: Icons.api,
    level: 'Advanced',
    score: 90,
    description: 'Connect applications to backend services and handle HTTP requests, JSON, tokens, and errors.',
  ),
  SkillData(
    name: 'Firebase Authentication',
    category: 'Backend & Database',
    icon: Icons.verified_user,
    level: 'Advanced',
    score: 94,
    description: 'Implement user sign-in, registration, session handling, and access-aware application flows.',
  ),
  SkillData(
    name: 'Firebase Storage',
    category: 'Backend & Database',
    icon: Icons.cloud_upload,
    level: 'Advanced',
    score: 88,
    description: 'Upload, store, and retrieve application files using Firebase Storage and access controls.',
  ),

  // AI & Automation — 5 skills
  SkillData(
    name: 'AI Agent Development',
    category: 'AI & Automation',
    icon: Icons.smart_toy,
    level: 'Advanced',
    score: 92,
    description: 'Build AI agents that understand requests, generate responses, and automate tasks using models and tools.',
  ),
  SkillData(
    name: 'n8n Workflow Automation',
    category: 'AI & Automation',
    icon: Icons.account_tree,
    level: 'Advanced',
    score: 82,
    description: 'Automate tasks by connecting apps, APIs, triggers, actions, and workflows in n8n.',
  ),
  SkillData(
    name: 'OpenAI API',
    category: 'AI & Automation',
    icon: Icons.psychology,
    level: 'Advanced',
    score: 91,
    description: 'Integrate OpenAI models for chat, text generation, prompt handling, and application workflows.',
  ),
  SkillData(
    name: 'Google Gemini API',
    category: 'AI & Automation',
    icon: Icons.auto_awesome,
    level: 'Advanced',
    score: 90,
    description: 'Use Gemini for conversational features, contextual responses, and AI-assisted tools.',
  ),
  SkillData(
    name: 'Webhooks',
    category: 'AI & Automation',
    icon: Icons.webhook,
    level: 'Advanced',
    score: 85,
    description: 'Connect services, process event payloads, and trigger automated workflows securely.',
  ),

  // Development Tools — 5 skills
  SkillData(
    name: 'Git & GitHub',
    category: 'Development Tools',
    icon: Icons.code_outlined,
    level: 'Advanced',
    score: 90,
    description: 'Manage source code with repositories, commits, branches, pull requests, and merges.',
  ),
  SkillData(
    name: 'GitHub Actions',
    category: 'Development Tools',
    icon: Icons.rocket_launch,
    level: 'Advanced',
    score: 85,
    description: 'Configure CI workflows for automated checks, builds, and deployment pipelines.',
  ),
  SkillData(
    name: 'Firebase Hosting',
    category: 'Development Tools',
    icon: Icons.cloud,
    level: 'Advanced',
    score: 86,
    description: 'Publish and manage Flutter web applications using Firebase Hosting configuration and deployment.',
  ),
  SkillData(
    name: 'Flutter Web Deployment',
    category: 'Development Tools',
    icon: Icons.web,
    level: 'Advanced',
    score: 88,
    description: 'Prepare release builds and configure base paths and hosting for Flutter web projects.',
  ),
  SkillData(
    name: 'Firebase CLI',
    category: 'Development Tools',
    icon: Icons.terminal,
    level: 'Advanced',
    score: 85,
    description: 'Configure Firebase projects and deploy web applications using command-line workflows.',
  ),
];
