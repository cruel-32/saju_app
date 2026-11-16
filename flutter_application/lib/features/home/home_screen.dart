import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../data/sample_chart.dart';
import '../../domain/saju.dart';
import '../gyeok/gyeok_screen.dart';
import '../manse/manse_screen.dart';
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
  int _tab = 0;

  Widget _body() {
    switch (_tab) {
      case 0:
        return HomeTab(
          chart: sampleChart,
          onSelectTab: (i) => setState(() => _tab = i),
        );
      case 1:
        return GyeokScreen(chart: sampleChart, asTab: true);
      case 2:
        return ManseScreen(chart: sampleChart, asTab: true);
      default:
        return const _MyTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tab == 0 || _tab == 3 ? SafeArea(child: _body()) : _body(),
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
  const HomeTab({super.key, required this.chart, this.onSelectTab});

  final SajuChart chart;

  /// 하단 탭으로 전환합니다 (1: 나의 분석, 2: 만세력).
  final ValueChanged<int>? onSelectTab;

  void _open(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
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
            onSwitchProfile: () => _open(context, Routes.input),
          ),
          const SizedBox(height: 8),
          PillarsCard(
            chart: chart,
            onTap: () => onSelectTab == null
                ? _open(context, Routes.manse)
                : onSelectTab!(2),
          ),
          const SizedBox(height: 14),
          GyeokCard(
            chart: chart,
            onTap: () => onSelectTab == null
                ? _open(context, Routes.gyeok)
                : onSelectTab!(1),
          ),
          const SizedBox(height: 20),
          PremiumSection(
            currentLuck: chart.currentLuck,
            onOpen: (route) => _open(context, route),
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

/// 마이 탭 (사주 관리로 연결만 해 둔 상태).
class _MyTab extends StatelessWidget {
  const _MyTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '마이 화면은 준비 중입니다',
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(Routes.input),
            child: const Text('사주 정보 입력'),
          ),
        ],
      ),
    );
  }
}
