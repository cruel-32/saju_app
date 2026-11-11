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

  test('간지 문자열로 기둥을 만든다', () {
    final day = Pillar.of('일주', '甲寅', isDay: true);
    expect(day.stem.ohaeng, Ohaeng.wood);
    expect(day.branch.hangul, '인');
    expect(day.hangul, '갑인');
    expect(() => Pillar.of('일주', '甲'), throwsArgumentError);
  });
}
