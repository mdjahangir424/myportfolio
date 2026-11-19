
import 'package:flutter/material.dart';

import '../widgets/section_title.dart';
import '../widgets/footer.dart';

class AutomationScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const AutomationScreen({
    super.key,
    required this.onNavigate,
  });

  static const List<Map<String, dynamic>> automationServices = [
    {
      'title': 'AI Agent Development',
      'description':
          'Intelligent AI agents designed to automate conversations and business tasks.',
      'icon': Icons.smart_toy_outlined,
      'features': [
        'AI-powered assistants',
        'Automated customer support',
        'Intelligent task handling',
      ],
    },
    {
      'title': 'n8n Workflow Automation',
      'description':
          'Connect applications and automate repetitive workflows with n8n.',
      'icon': Icons.account_tree_outlined,
      'features': [
        'Workflow design',
        'App integrations',
        'Automated data processing',
      ],
    },
    {
      'title': 'Business Process Automation',
      'description':
          'Reduce manual work and improve operational efficiency through automation.',
      'icon': Icons.business_center_outlined,
      'features': [
        'Task automation',
        'Business workflows',
        'Process optimization',
      ],
    },
    {
      'title': 'API & Webhook Integration',
      'description':
          'Connect different platforms and services using APIs and webhooks.',
      'icon': Icons.api_outlined,
      'features': [
        'REST API integration',
        'Webhook configuration',
        'Application connectivity',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                ),
                child: Column(
                  children: [
                    const SectionTitle(
                      title: 'AI & Automation',
                      subtitle:
                          'Building smarter workflows with AI agents, n8n, APIs, '
                          'and intelligent automation.',
                    ),
                    const SizedBox(height: 40),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final count =
                            constraints.maxWidth >= 900 ? 2 : 1;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: automationServices.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: count,
                            crossAxisSpacing: 22,
                            mainAxisSpacing: 22,
                            mainAxisExtent: 245,
                          ),
                          itemBuilder: (context, index) {
                            final item = automationServices[index];

                            return Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius:
                                    BorderRadius.circular(18),
                                border: Border.all(
                                  color: theme.dividerColor.withValues(
                                    alpha: 0.15,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    item['icon'] as IconData,
                                    size: 34,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    item['title'] as String,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['description'] as String,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  const Spacer(),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 6,
                                    children:
                                        (item['features'] as List<String>)
                                            .map(
                                      (feature) => Chip(
                                        label: Text(
                                          feature,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        visualDensity:
                                            VisualDensity.compact,
                                      ),
                                    ).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Shared Footer
          PortfolioFooter(
            onNavigate: onNavigate,
          ),
        ],
      ),
    );
  }
}
