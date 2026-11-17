
import 'package:flutter/material.dart';
import '../models/service_model.dart';

const List<ServiceModel> servicesData = [
  ServiceModel(
    title: 'Flutter App Development',
    description:
        'Development of modern, responsive cross-platform mobile applications for Android and iOS using Flutter and Dart.',
    icon: Icons.phone_android,
    features: [
      'Custom Android & iOS Applications',
      'Responsive UI Development',
      'Firebase Integration',
      'API Integration',
    ],
  ),
  ServiceModel(
    title: 'AI Agent Development',
    description:
        'Building AI-powered agents designed to support customer interactions, business operations and intelligent workflows.',
    icon: Icons.smart_toy,
    features: [
      'Conversational AI Agents',
      'OpenAI API Integration',
      'Google Gemini API Integration',
      'Business AI Solutions',
    ],
  ),
  ServiceModel(
    title: 'n8n Workflow Automation',
    description:
        'Designing automated workflows that connect applications, APIs and business processes using n8n.',
    icon: Icons.account_tree,
    features: [
      'Workflow Design & Development',
      'API and Webhook Integration',
      'Data Processing Automation',
      'Third-Party App Connections',
    ],
  ),
  ServiceModel(
    title: 'Business Process Automation',
    description:
        'Creating automation solutions to reduce repetitive manual tasks and improve business workflow efficiency.',
    icon: Icons.business_center,
    features: [
      'Task Automation',
      'Automated Notifications',
      'Lead Management Workflows',
      'Process Optimization',
    ],
  ),
  ServiceModel(
    title: 'Firebase & Backend Integration',
    description:
        'Integrating Firebase services and backend APIs to support application data, authentication and cloud functionality.',
    icon: Icons.cloud,
    features: [
      'Firebase Authentication',
      'Cloud Firestore Integration',
      'Cloud Data Management',
      'REST API Integration',
    ],
  ),
  ServiceModel(
    title: 'API & Webhook Integration',
    description:
        'Connecting applications and external services through APIs and webhooks to enable reliable data exchange.',
    icon: Icons.integration_instructions,
    features: [
      'REST API Integration',
      'Webhook Configuration',
      'Application Connectivity',
      'Data Synchronization',
    ],
  ),
];
