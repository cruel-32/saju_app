import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../data/sample_chart.dart';
import '../../domain/saju.dart';
import 'widgets/gyeok_card.dart';
import 'widgets/pillars_card.dart';
import 'widgets/premium_section.dart';

/// 하단 탭(홈 · 나의 분석 · 만세력 · 마이)을 가진 첫 화면.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _tabLabels = ['홈', '나의 분석', '만세력', '마이'];

  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _tab == 0
            ? HomeTab(chart: sampleChart)
            : _ComingSoon(label: _tabLabels[_tab]),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: '나의 분석',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: '만세력',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }
}

/// 홈 탭 본문.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.chart});

  final SajuChart chart;

  void _comingSoon(BuildContext context, String what) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$what 화면은 준비 중입니다')));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(
            name: chart.name,
            onSwitchProfile: () => _comingSoon(context, '사주 선택'),
          ),
          const SizedBox(height: 8),
          PillarsCard(
            chart: chart,
            onTap: () => _comingSoon(context, '나의 만세력'),
          ),
          const SizedBox(height: 14),
          GyeokCard(
            chart: chart,
            onTap: () => _comingSoon(context, '나의 격'),
          ),
          const SizedBox(height: 20),
          PremiumSection(
            currentLuck: chart.currentLuck,
            onOpen: (title) => _comingSoon(context, title),
          ),
          const SizedBox(height: 16),
          const Text(
            '준비 중 · 심리분석 · 사주와 심리 통합분석 · 전문 상담',
            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.name, required this.onSwitchProfile});

  final String name;
  final VoidCallback onSwitchProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '보리음',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: AppColors.gold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onSwitchProfile,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textMuted,
            minimumSize: const Size(44, 44),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name, style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 4),
              const Icon(Icons.expand_more, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label 화면은 준비 중입니다',
        style: const TextStyle(color: AppColors.textMuted),
      ),
    );
  }
}
