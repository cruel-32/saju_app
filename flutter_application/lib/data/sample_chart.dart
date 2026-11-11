import '../domain/saju.dart';

/// 보리음 사양서의 검증 케이스 (1981-12-02 12:30, 여성).
/// 만세력 엔진이 생기면 엔진 결과로 대체합니다.
final SajuChart sampleChart = SajuChart(
  name: '홍길동',
  birthSummary: '양 1981.12.02 12:30 · 여',
  pillars: [
    Pillar.of('시주', '庚午'),
    Pillar.of('일주', '甲寅', isDay: true),
    Pillar.of('월주', '己亥'),
    Pillar.of('년주', '辛酉'),
  ],
  gyeokName: '편인격',
  gyeokHanja: '偏印格',
  isGyeokSample: true,
  currentLuck: '甲辰',
);
