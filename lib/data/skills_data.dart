import 'package:flutter/material.dart';

class SkillData {
  final String name;
  final String category;
  final IconData icon;
  final String level;
  final int score;
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
  // Flutter & Mobile Development
  SkillData(
    name: 'Flutter',
    category: 'Mobile Development',
    icon: Icons.phone_android,
    level: 'Expert',
    score: 98,
    description:
        'Build complete cross-platform Android and iOS applications with '
        'responsive interfaces, smooth navigation, API integration, and '
        'Firebase connectivity. Focus on reusable components, maintainable '
        'code, and polished user experiences.',
  ),
  SkillData(
    name: 'Dart',
    category: 'Mobile Development',
    icon: Icons.code,
    level: 'Expert',
    score: 96,
    description:
        'Develop application logic with object-oriented programming, '
        'asynchronous operations, null safety, collections, and reusable '
        'code structures. Apply these fundamentals to build reliable and '
        'maintainable Flutter applications.',
  ),
  SkillData(
    name: 'Android App Development',
    category: 'Mobile Development',
    icon: Icons.android,
    level: 'Advanced',
    score: 84,
    description:
        'Develop native Android applications using Kotlin and Jetpack Compose. '
        'Create modern interfaces, manage application state and navigation, '
        'integrate APIs and Firebase, and build functional Android experiences.',
  ),

  // Backend & Database
  SkillData(
    name: 'Firebase',
    category: 'Backend & Database',
    icon: Icons.local_fire_department,
    level: 'Expert',
    score: 98,
    description:
        'Integrate Firebase services such as Authentication, Cloud Firestore, '
        'and Cloud Storage into mobile applications. Implement secure access, '
        'cloud backup and restore, and reliable data synchronization.',
  ),
  SkillData(
    name: 'Cloud Firestore',
    category: 'Backend & Database',
    icon: Icons.storage,
    level: 'Expert',
    score: 96,
    description:
        'Design and manage cloud-based NoSQL databases using collections '
        'and documents. Work with CRUD operations, real-time updates, '
        'Firestore Security Rules, offline data, and device synchronization.',
  ),
  SkillData(
    name: 'REST API',
    category: 'Backend & Database',
    icon: Icons.api,
    level: 'Advanced',
    score: 90,
    description:
        'Connect applications with backend services through HTTP requests '
        'and JSON responses. Handle authentication tokens, data parsing, '
        'request states, and API errors to support dependable integrations.',
  ),

  // AI & Automation
  SkillData(
    name: 'AI Agent Development',
    category: 'AI & Automation',
    icon: Icons.smart_toy,
    level: 'Advanced',
    score: 92,
    description:
        'Build AI-powered agents that understand user requests, generate '
        'useful responses, and support task automation. Integrate language '
        'models with tools and external services for practical workflows.',
  ),
  SkillData(
    name: 'n8n Workflow Automation',
    category: 'AI & Automation',
    icon: Icons.account_tree,
    level: 'Advanced',
    score: 82,
    description:
        'Create automated workflows by connecting applications, APIs, '
        'triggers, and actions in n8n. Process data, use webhooks, and reduce '
        'repetitive manual tasks through connected automation workflows.',
  ),
  SkillData(
    name: 'OpenAI API',
    category: 'AI & Automation',
    icon: Icons.psychology,
    level: 'Advanced',
    score: 91,
    description:
        'Integrate OpenAI models into applications and AI-powered systems. '
        'Build conversational features, generate text, process user prompts, '
        'and connect model capabilities with application backends and tools.',
  ),
  SkillData(
    name: 'Google Gemini API',
    category: 'AI & Automation',
    icon: Icons.auto_awesome,
    level: 'Advanced',
    score: 90,
    description:
        'Use the Gemini API to add generative AI capabilities to applications. '
        'Implement conversational experiences, content generation, contextual '
        'responses, and AI-assisted features through API integration.',
  ),
  SkillData(
    name: 'Webhooks',
    category: 'AI & Automation',
    icon: Icons.webhook,
    level: 'Advanced',
    score: 85,
    description:
        'Connect applications and external services through event-driven '
        'webhook communication. Configure endpoints, receive event payloads, '
        'process incoming data, and trigger connected workflows.',
  ),

  // Development Tools
  SkillData(
    name: 'Git & GitHub',
    category: 'Development Tools',
    icon: Icons.code_outlined,
    level: 'Advanced',
    score: 90,
    description:
        'Manage source code and collaborative development workflows with Git '
        'and GitHub. Work with repositories, commits, branches, pull requests, '
        'merges, and version history to keep projects organized.',
  ),
];
