
import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String skillName;
  final String level;
  final double proficiency;
  final IconData icon;

  const SkillCard({
    super.key,
    required this.skillName,
    required this.level,
    required this.proficiency,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final safeProficiency = proficiency.clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colors.outline.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: colors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  skillName,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                level,
                style: TextStyle(
                  color: colors.onSurface.withOpacity(0.65),
                  fontSize: 13,
                ),
              ),
              Text(
                '${(safeProficiency * 100).round()}%',
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: safeProficiency,
              minHeight: 7,
              backgroundColor: colors.primary.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(
                colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
