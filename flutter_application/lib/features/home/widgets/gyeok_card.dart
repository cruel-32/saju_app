import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../domain/saju.dart';
import '../../../widgets/surface_card.dart';

/// 무료 진입 서비스 '나의 격 알아보기' 카드.
class GyeokCard extends StatelessWidget {
  const GyeokCard({super.key, required this.chart, this.onTap});

  final SajuChart chart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      highlight: true,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TagChip.free(),
              const Spacer(),
              if (chart.isGyeokSample)
                const Text(
                  '격 판정 예시',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '나의 격',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                chart.gyeokName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                chart.gyeokHanja,
                style: const TextStyle(fontSize: 18, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '타고난 성향, 오행·십성 구성, 대표 강점을 확인하세요.',
            style: TextStyle(
              fontSize: 13,
              height: 1.55,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '나의 격 알아보기 ›',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }
}
