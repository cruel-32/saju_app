import 'package:flutter/material.dart';

import '../data/sample_chart.dart';
import '../features/analysis/analysis_screens.dart';
import '../features/gyeok/gyeok_screen.dart';
import '../features/home/home_screen.dart';
import '../features/input/input_screen.dart';
import '../features/loading/loading_screen.dart';
import '../features/manse/manse_screen.dart';
import '../features/premium/premium_screen.dart';

/// 화면 경로 이름.
abstract final class Routes {
  static const home = '/';
  static const input = '/input';
  static const loading = '/loading';
  static const manse = '/manse';
  static const gyeok = '/gyeok';
  static const premium = '/premium';
  static const role = '/analysis/role';
  static const talent = '/analysis/talent';
  static const career = '/analysis/career';
  static const flow = '/analysis/flow';
}

/// 지금은 모든 화면이 샘플 사주를 씁니다.
/// 엔진과 저장소가 생기면 여기서 실제 사주를 넘기도록 바꿉니다.
Map<String, WidgetBuilder> buildRoutes() {
  return {
    Routes.home: (_) => const HomeScreen(),
    Routes.input: (_) => const InputScreen(),
    Routes.loading: (_) => const LoadingScreen(),
    Routes.manse: (_) => ManseScreen(chart: sampleChart),
    Routes.gyeok: (_) => GyeokScreen(chart: sampleChart),
    Routes.premium: (_) => PremiumScreen(chart: sampleChart),
    Routes.role: (_) => RoleScreen(chart: sampleChart),
    Routes.talent: (_) => TalentScreen(chart: sampleChart),
    Routes.career: (_) => CareerScreen(chart: sampleChart),
    Routes.flow: (_) => FlowScreen(chart: sampleChart),
  };
}
