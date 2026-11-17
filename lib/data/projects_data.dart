
import '../models/project_model.dart';

const List<ProjectModel> projectsData = [
  ProjectModel(
    title: 'SkillSwap',
    description:
        'A skill-sharing community platform designed to connect people who want to learn, teach and exchange skills through a modern cross-platform experience.',
    category: 'Mobile Application',
    status: 'In Development',
    technologies:
        'Flutter, Dart, Firebase, Cloud Firestore, Firebase Auth',
    image: 'assets/images/skillswap.png',
    githubUrl: 'https://github.com/mdjahangir424/skillswap',
    liveUrl: '',
  ),

  ProjectModel(
    title: 'Hisab Khata',
    description:
        'A digital expense and accounting application concept designed to organize daily transactions, track expenses and manage financial records.',
    category: 'Finance & Productivity',
    status: 'Prototype / Development',
    technologies:
        'Flutter, Dart, Firebase, Database Integration',
    image: 'assets/images/hisab_khata.png',
    githubUrl: '',
    liveUrl: '',
  ),

  ProjectModel(
    title: 'AI Agent & Workflow Automation',
    description:
        'An automation-focused project exploring AI agents, intelligent workflows and application integrations to simplify repetitive business processes.',
    category: 'AI & Automation',
    status: 'Development / Portfolio Showcase',
    technologies:
        'n8n, OpenAI API, Google Gemini API, REST API, Webhooks',
    image: 'assets/images/ai_automation.png',
    githubUrl: '',
    liveUrl: '',
  ),
];
