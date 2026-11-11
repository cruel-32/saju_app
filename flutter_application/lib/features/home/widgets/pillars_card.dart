import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../domain/saju.dart';
import '../../../widgets/surface_card.dart';

/// 홈의 '나의 만세력' 카드: 4기둥 8글자를 오행 색으로 보여 줍니다.
class PillarsCard extends StatelessWidget {
  const PillarsCard({super.key, required this.chart, this.onTap});

  final SajuChart chart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                '나의 만세력',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const Spacer(),
              Text(
                chart.birthSummary,
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final pillar in chart.pillars)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _PillarColumn(pillar: pillar),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PillarColumn extends StatelessWidget {
  const _PillarColumn({required this.pillar});

  final Pillar pillar;

  @override
  Widget build(BuildContext context) {
    final isDay = pillar.isDay;
    return Semantics(
      label: '${pillar.label} ${pillar.hangul}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: isDay
            ? BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Column(
          children: [
            Text(
              isDay ? '${pillar.label} (나)' : pillar.label,
              style: TextStyle(
                fontSize: 11,
                color: isDay ? AppColors.gold : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 4),
            _HanjaGlyph(ganji: pillar.stem),
            _HanjaGlyph(ganji: pillar.branch),
          ],
        ),
      ),
    );
  }
}

class _HanjaGlyph extends StatelessWidget {
  const _HanjaGlyph({required this.ganji});

  final Ganji ganji;

  @override
  Widget build(BuildContext context) {
    return Text(
      ganji.hanja,
      style: TextStyle(
        fontSize: 24,
        height: 1.3,
        fontWeight: FontWeight.w700,
        color: AppColors.ohaeng(ganji.ohaeng),
      ),
    );
  }
}
