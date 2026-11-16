import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../widgets/common.dart';

/// 심층 분석 항목.
enum AnalysisSection {
  gyeok('격', '① 나의 격 심층 분석', Routes.premium),
  role('역할', '② 사회적 역할', Routes.role),
  talent('재능', '③ 나의 재능', Routes.talent),
  career('진로', '④ 진로와 직업', Routes.career),
  flow('흐름', '⑤ 대운에 따른 인생의 흐름', Routes.flow);

  const AnalysisSection(this.short, this.title, this.route);

  final String short;
  final String title;
  final String route;
}

/// 심층 분석 화면 공통 틀: 상단 바, 항목 칩, 제목, 본문, 근거 상자.
class AnalysisScaffold extends StatelessWidget {
  const AnalysisScaffold({
    super.key,
    required this.section,
    required this.children,
    this.headline,
    this.basis = const [],
  });

  final AnalysisSection section;

  /// 제목 아래 큰 한 줄 요약 (없으면 생략).
  final String? headline;
  final List<Widget> children;

  /// 이 풀이의 근거가 된 계산값.
  final List<String> basis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSubAppBar('나의 가능성 심층 분석'),
      body: Column(
        children: [
          _SectionChips(current: section),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.paid,
                  ),
                ),
                if (headline != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    headline!,
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.45,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                ...children,
                if (basis.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  BasisBox(items: basis),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionChips extends StatelessWidget {
  const _SectionChips({required this.current});

  final AnalysisSection current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        children: [
          for (final s in AnalysisSection.values)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: _chip(context, s),
            ),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, AnalysisSection s) {
    final on = s == current;
    return TextButton(
      onPressed: on
          ? null
          : () => Navigator.of(context).pushReplacementNamed(s.route),
      style: TextButton.styleFrom(
        minimumSize: const Size(44, 34),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: on ? AppColors.gold : Colors.transparent,
        disabledBackgroundColor: AppColors.gold,
        foregroundColor: AppColors.textMuted,
        disabledForegroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(color: on ? AppColors.gold : AppColors.border),
        ),
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: on ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
      child: Text(s.short),
    );
  }
}
