import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/saju.dart';
import '../../widgets/common.dart';
import '../../widgets/surface_card.dart';
import 'analysis_scaffold.dart';

/// 제목 + 해석 문단 카드.
class _ParagraphCard extends StatelessWidget {
  const _ParagraphCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title),
            const SizedBox(height: 6),
            PlaceholderParagraph(text),
          ],
        ),
      ),
    );
  }
}

// ── ② 사회적 역할 ─────────────────────────────────────────

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key, required this.chart});

  final SajuChart chart;

  /// 예시 강조. 판정 규칙이 생기면 계산 결과로 바뀝니다.
  static const _roles = [
    ('조직', true),
    ('전문직', true),
    ('창업', false),
    ('교육', true),
    ('상담', false),
  ];

  @override
  Widget build(BuildContext context) {
    return AnalysisScaffold(
      section: AnalysisSection.role,
      headline: '[역할 한 줄 요약]',
      basis: [chart.gyeokName, '관성 3', '정관 년간 투출', '甲庚 충'],
      children: [
        const SectionTitle('잘 맞는 역할 유형'),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < _roles.length; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(child: _RoleBox(label: _roles[i].$1, on: _roles[i].$2)),
            ],
          ],
        ),
        const SizedBox(height: 6),
        const MutedText('강조 표시는 예시입니다', fontSize: 11),
        const SizedBox(height: 14),
        const _ParagraphCard(title: '영향력을 발휘하는 방식', text: '[해석 문단 · 3~4문장]'),
        const _ParagraphCard(title: '적합한 활동 환경', text: '[해석 문단 · 3~4문장]'),
      ],
    );
  }
}

class _RoleBox extends StatelessWidget {
  const _RoleBox({required this.label, required this.on});

  final String label;
  final bool on;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: on ? AppColors.surfaceHigh : AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: on ? AppColors.gold : AppColors.border,
          width: on ? 1.5 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: on ? FontWeight.w700 : FontWeight.w400,
          color: on ? AppColors.text : AppColors.textMuted,
        ),
      ),
    );
  }
}

// ── ③ 나의 재능 ───────────────────────────────────────────

class TalentScreen extends StatelessWidget {
  const TalentScreen({super.key, required this.chart});

  final SajuChart chart;

  static const _abilities = ['사고력', '기획력', '표현력', '실행력'];

  @override
  Widget build(BuildContext context) {
    final cards = [
      for (final a in _abilities)
        SurfaceCard(
          radius: 14,
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    a,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '[수준]',
                    style: TextStyle(fontSize: 12, color: AppColors.gold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const MutedText('[짧은 설명]', fontSize: 12, height: 1.5),
            ],
          ),
        ),
    ];

    return AnalysisScaffold(
      section: AnalysisSection.talent,
      headline: '[재능 한 줄 요약]',
      basis: const ['상관 午 (시지)', '편인 亥 (월지)', '寅午 반합', '일지 건록'],
      children: [
        Row(
          children: [
            Expanded(child: cards[0]),
            const SizedBox(width: 8),
            Expanded(child: cards[1]),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: cards[2]),
            const SizedBox(width: 8),
            Expanded(child: cards[3]),
          ],
        ),
        const SizedBox(height: 12),
        const SurfaceCard(
          child: Column(
            children: [
              _ConditionRow(
                label: '발휘 조건',
                foreground: AppColors.free,
                background: AppColors.freeBg,
                text: '[재능이 살아나는 조건]',
              ),
              SizedBox(height: 10),
              _ConditionRow(
                label: '방해 요인',
                foreground: Color(0xFFF2A39A),
                background: Color(0xFF3D2A28),
                text: '[재능을 막는 요인]',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConditionRow extends StatelessWidget {
  const _ConditionRow({
    required this.label,
    required this.foreground,
    required this.background,
    required this.text,
  });

  final String label;
  final Color foreground;
  final Color background;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: foreground,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: MutedText(text, fontSize: 13)),
      ],
    );
  }
}

// ── ④ 진로와 직업 ─────────────────────────────────────────

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key, required this.chart});

  final SajuChart chart;

  /// 0 = 독립형, 1 = 조직형. 예시 값입니다.
  static const _orgFit = 0.68;

  @override
  Widget build(BuildContext context) {
    return AnalysisScaffold(
      section: AnalysisSection.career,
      headline: '[진로 한 줄 요약]',
      basis: [chart.gyeokName, '관성 3', '재성 1', '용신 ${chart.useGod}'],
      children: [
        const SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle('적합한 직업군과 직무'),
              SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  InfoChip('[직업군 1]', radius: 999, fontSize: 13),
                  InfoChip('[직업군 2]', radius: 999, fontSize: 13),
                  InfoChip('[직업군 3]', radius: 999, fontSize: 13),
                  InfoChip('[직무 1]', radius: 999, fontSize: 13),
                  InfoChip('[직무 2]', radius: 999, fontSize: 13),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('독립형과 조직형 적합성'),
              const SizedBox(height: 10),
              const Row(
                children: [
                  MutedText('독립형', fontSize: 12),
                  Spacer(),
                  MutedText('조직형', fontSize: 12),
                ],
              ),
              const SizedBox(height: 6),
              LayoutBuilder(
                builder: (context, c) => SizedBox(
                  height: 18,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 5,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      Positioned(
                        left: (c.maxWidth - 18) * _orgFit,
                        top: 0,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: AppColors.gold,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const MutedText('[해석 문단] · 위치는 예시입니다', fontSize: 13),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _ParagraphCard(title: '직업 전환과 경력 개발 방향', text: '[해석 문단 · 3~4문장]'),
      ],
    );
  }
}

// ── ⑤ 대운에 따른 인생의 흐름 ─────────────────────────────

class FlowScreen extends StatefulWidget {
  const FlowScreen({super.key, required this.chart});

  final SajuChart chart;

  @override
  State<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends State<FlowScreen> {
  late LuckPeriod _selected = widget.chart.currentLuckPeriod;

  @override
  Widget build(BuildContext context) {
    final chart = widget.chart;
    final p = _selected;

    return AnalysisScaffold(
      section: AnalysisSection.flow,
      children: [
        MutedText(
          '대운수 ${chart.luckStartAge} · ${chart.luckForward ? '순행' : '역행'} · 10년마다 바뀝니다',
          fontSize: 12,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var i = 0; i < chart.luckPeriods.length; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              Expanded(child: _luckButton(chart.luckPeriods[i])),
            ],
          ],
        ),
        const SizedBox(height: 14),
        SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GanjiText(p.ganji, fontSize: 22),
                  const Text(
                    ' 대운',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const Spacer(),
                  MutedText(
                    p.isCurrent ? '${p.years} · 현재' : p.years,
                    fontSize: 12,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                children: [
                  InfoChip('십신 ${p.tenGods}'),
                  InfoChip('12운성 ${p.stage}'),
                ],
              ),
              const SizedBox(height: 10),
              const PlaceholderParagraph('[이 시기의 활동 흐름 해석 · 3~4문장]'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const SectionTitle('가까운 세운'),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < chart.yearLucks.length; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(child: _YearBox(luck: chart.yearLucks[i])),
            ],
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceAccent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.paid),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '진로 변화와 기회의 시기',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.paid,
                ),
              ),
              SizedBox(height: 4),
              MutedText('[판정 규칙에 따라 표시할 시기와 설명]', fontSize: 13),
            ],
          ),
        ),
      ],
    );
  }

  Widget _luckButton(LuckPeriod period) {
    final on = identical(period, _selected);
    return Material(
      color: on ? AppColors.surfaceHigh : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: on ? AppColors.gold : AppColors.border,
          width: on ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _selected = period),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              MutedText('${period.startAge}세', fontSize: 10, height: 1.3),
              const SizedBox(height: 2),
              GanjiText('${period.ganji[0]}\n${period.ganji[1]}', fontSize: 16, height: 1.2),
            ],
          ),
        ),
      ),
    );
  }
}

class _YearBox extends StatelessWidget {
  const _YearBox({required this.luck});

  final YearLuck luck;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: luck.isCurrent ? AppColors.surfaceHigh : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: luck.isCurrent ? AppColors.gold : AppColors.border,
          width: luck.isCurrent ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            '${luck.year}',
            style: TextStyle(
              fontSize: 11,
              color: luck.isCurrent ? AppColors.gold : AppColors.textMuted,
            ),
          ),
          GanjiText(luck.ganji, fontSize: 17),
          MutedText(luck.tenGods, fontSize: 11, height: 1.3),
        ],
      ),
    );
  }
}
