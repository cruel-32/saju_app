import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../domain/saju.dart';
import '../../widgets/common.dart';
import '../../widgets/surface_card.dart';

/// 유료 '나의 가능성 심층 분석' 안내 화면.
/// 결제는 아직 없고, 버튼을 누르면 첫 분석 화면으로 넘어갑니다.
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key, required this.chart});

  final SajuChart chart;

  static const _sections = [
    ('나의 격 심층 분석', '격국의 성립 조건과 완성도 · 구조의 장단점 · 용신·희신·기신'),
    ('사회적 역할', '역할 유형 · 영향력을 발휘하는 방식 · 적합한 활동 환경'),
    ('나의 재능', '사고력·기획력·표현력·실행력 · 발휘 조건과 방해 요인'),
    ('진로와 직업', '직업군과 직무 · 독립형/조직형 적합성 · 경력 개발 방향'),
    ('인생의 흐름', '대운·세운에 따른 활동 시기 · 진로 변화와 기회의 시기'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSubAppBar(''),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TagChip(
                      label: '유료 · 심층 분석',
                      foreground: AppColors.paid,
                      background: AppColors.paidBg,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '나의 가능성\n심층 분석',
                    style: TextStyle(
                      fontSize: 26,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MutedText(
                    '${chart.gyeokName} ${chart.name}님의 원국과 대운을 바탕으로 다섯 가지 영역을 풀어 드립니다.',
                    fontSize: 14,
                    height: 1.6,
                  ),
                  const SizedBox(height: 16),
                  for (var i = 0; i < _sections.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SurfaceCard(
                        radius: 14,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 22,
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.paid,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _sections[i].$1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.text,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  MutedText(_sections[i].$2, fontSize: 12, height: 1.5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      MutedText('평생 소장 · 다시 보기 무제한', fontSize: 14),
                      Spacer(),
                      Text(
                        '[가격]',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    label: '심층 분석 받기',
                    onPressed: () => Navigator.of(context).pushNamed(Routes.role),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
