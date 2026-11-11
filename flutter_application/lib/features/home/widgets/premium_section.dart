import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../widgets/surface_card.dart';

/// 유료 '나의 가능성 심층 분석' 메뉴 묶음.
class PremiumSection extends StatelessWidget {
  const PremiumSection({
    super.key,
    required this.currentLuck,
    required this.onOpen,
  });

  /// 현재 대운 간지 (예: 甲辰).
  final String currentLuck;

  /// 메뉴 제목을 받아 해당 화면을 엽니다.
  final ValueChanged<String> onOpen;

  static const _menus = [
    (title: '나의 격 심층 분석', sub: '성립 조건 · 용신'),
    (title: '사회적 역할', sub: '역할 유형 · 환경'),
    (title: '나의 재능', sub: '사고·기획·표현·실행'),
    (title: '진로와 직업', sub: '직업군 · 독립/조직'),
  ];

  @override
  Widget build(BuildContext context) {
    Widget tile(int i) => Expanded(
          child: _MenuTile(
            title: _menus[i].title,
            subtitle: _menus[i].sub,
            onTap: () => onOpen(_menus[i].title),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Text(
              '나의 가능성 심층 분석',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            Spacer(),
            TagChip.paid(),
          ],
        ),
        const SizedBox(height: 8),
        Row(children: [tile(0), const SizedBox(width: 8), tile(1)]),
        const SizedBox(height: 8),
        Row(children: [tile(2), const SizedBox(width: 8), tile(3)]),
        const SizedBox(height: 8),
        SurfaceCard(
          radius: 12,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          onTap: () => onOpen('대운에 따른 인생의 흐름'),
          child: Row(
            children: [
              const Text(
                '대운에 따른 인생의 흐름',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
              const Spacer(),
              Text(
                '현재 $currentLuck 대운 ›',
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 12,
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
