import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application/app/app.dart';
import 'package:flutter_application/domain/saju.dart';

void main() {
  testWidgets('홈 화면에 만세력·격·심층 분석이 보인다', (tester) async {
    await tester.pumpWidget(const BoriumApp());

    expect(find.text('나의 만세력'), findsOneWidget);
    expect(find.text('편인격'), findsOneWidget);
    expect(find.text('나의 가능성 심층 분석'), findsOneWidget);
    expect(find.text('甲'), findsOneWidget);
  });

  testWidgets('심층 분석 메뉴를 누르면 사회적 역할 화면이 열린다', (tester) async {
    await tester.pumpWidget(const BoriumApp());

    final menu = find.text('사회적 역할');
    await tester.ensureVisible(menu);
    await tester.tap(menu);
    await tester.pumpAndSettle();

    expect(find.text('② 사회적 역할'), findsOneWidget);
  });

  testWidgets('만세력 탭에 원국 표가 보인다', (tester) async {
    await tester.pumpWidget(const BoriumApp());

    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await tester.pumpAndSettle();

    expect(find.text('12운성'), findsOneWidget);
    expect(find.text('대계수'), findsOneWidget);
  });

  test('간지 문자열로 기둥을 만든다', () {
    final day = Pillar.of('일주', '甲寅', isDay: true);
    expect(day.stem.ohaeng, Ohaeng.wood);
    expect(day.branch.hangul, '인');
    expect(day.hangul, '갑인');
    expect(() => Pillar.of('일주', '甲'), throwsArgumentError);
  });
}
