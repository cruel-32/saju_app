import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../domain/saju.dart';
import '../../widgets/common.dart';
import '../../widgets/surface_card.dart';

/// 무료 진입 서비스 '나의 격 알아보기'.
/// 해석 문장은 전문가 집필 전이라 자리표시로 둡니다.
class GyeokScreen extends StatelessWidget {
  const GyeokScreen({super.key, required this.chart, this.asTab = false});

  final SajuChart chart;
  final bool asTab;

  @override
  Widget build(BuildContext context) {
    final groups = chart.tenGodGroups;
    final maxCount = groups.fold<int>(1, (m, g) => g.count > m ? g.count : m);
    final total = groups.fold<int>(0, (s, g) => s + g.count);

    return Scaffold(
      appBar: buildSubAppBar(
        '나의 격 알아보기',
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: TagChip.free()),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          if (chart.isGyeokSample)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.5)),
                ),
                child: const MutedText('예시 · 판정 기준 확정 전', fontSize: 11, height: 1.4),
              ),
            ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                chart.gyeokName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                chart.gyeokHanja,
                style: const TextStyle(fontSize: 20, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const PlaceholderParagraph(
            '[격 기본 설명 · 2~3문장] 월지 亥의 정기 壬이 일간 甲을 생하는 편인으로 자리한 구조입니다.',
          ),
          const SizedBox(height: 14),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('타고난 기본 성향'),
                const SizedBox(height: 10),
                for (final t in const ['[성향 문구 1]', '[성향 문구 2]', '[성향 문구 3]'])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '•  $t',
                      style: const TextStyle(fontSize: 14, height: 1.55, color: AppColors.text),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  '십성 구성',
                  trailing: MutedText('일간 제외 $total글자', fontSize: 11),
                ),
                const SizedBox(height: 12),
                for (final g in groups)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 44,
                          child: Text(
                            g.name,
                            style: const TextStyle(fontSize: 13, color: AppColors.text),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: g.count / maxCount,
                              minHeight: 10,
                              color: g.count == maxCount
                                  ? AppColors.gold
                                  : const Color(0xFF8A8F99),
                              backgroundColor: AppColors.surfaceHigh,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                          child: Text(
                            '${g.count}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: g.count == maxCount ? FontWeight.w700 : FontWeight.w400,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 2),
                MutedText(
                  '오행 · ${Ohaeng.values.map((o) => '${o.hangul} ${chart.ohaengCount[o] ?? 0}').join(' · ')}',
                  fontSize: 12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionTitle('대표 강점'),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              InfoChip('[강점 1]', radius: 999, fontSize: 13),
              InfoChip('[강점 2]', radius: 999, fontSize: 13),
              InfoChip('[강점 3]', radius: 999, fontSize: 13),
            ],
          ),
          const SizedBox(height: 18),
          Material(
            color: AppColors.surfaceAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.paid, width: 1.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(Routes.premium),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '더 알고 싶다면',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.paid,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '나의 가능성 심층 분석 보기 ›',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 4),
                    MutedText('격의 완성도, 사회적 역할, 재능, 진로, 대운 흐름', fontSize: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
