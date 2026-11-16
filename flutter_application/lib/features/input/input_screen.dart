import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../widgets/common.dart';

enum Gender { female, male }

enum CalendarType { solar, lunar, lunarLeap }

/// 사주 정보 입력 화면.
///
/// 지금은 입력값을 검증·저장하지 않고 로딩 화면으로만 넘어갑니다.
/// 엔진이 생기면 여기서 입력값을 모아 계산 요청을 보냅니다.
class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _name = TextEditingController(text: '홍길동');
  final _date = TextEditingController(text: '1981. 12. 02');
  final _time = TextEditingController(text: '12 : 30');

  Gender _gender = Gender.female;
  CalendarType _calendar = CalendarType.solar;
  bool _timeUnknown = false;
  String _place = '대한민국 · 서울';

  static const _places = ['대한민국 · 서울', '대한민국 · 부산', '해외 (도시 검색)'];

  @override
  void dispose() {
    _name.dispose();
    _date.dispose();
    _time.dispose();
    super.dispose();
  }

  InputDecoration _decoration() {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.gold, 1.5),
      disabledBorder: border(AppColors.border),
    );
  }

  @override
  Widget build(BuildContext context) {
    const fieldText = TextStyle(fontSize: 15, color: AppColors.text);

    return Scaffold(
      appBar: buildSubAppBar('사주 정보 입력'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const _Label('이름 또는 별명'),
            TextField(
              controller: _name,
              style: fieldText,
              decoration: _decoration(),
            ),
            const SizedBox(height: 18),
            const _Label('성별'),
            _ChoiceRow<Gender>(
              values: Gender.values,
              selected: _gender,
              labelOf: (g) => g == Gender.female ? '여성' : '남성',
              onSelected: (g) => setState(() => _gender = g),
            ),
            const SizedBox(height: 18),
            const _Label('달력'),
            _ChoiceRow<CalendarType>(
              values: CalendarType.values,
              selected: _calendar,
              labelOf: (c) => switch (c) {
                CalendarType.solar => '양력',
                CalendarType.lunar => '음력',
                CalendarType.lunarLeap => '음력 윤달',
              },
              onSelected: (c) => setState(() => _calendar = c),
            ),
            const SizedBox(height: 18),
            const _Label('생년월일'),
            TextField(
              controller: _date,
              keyboardType: TextInputType.datetime,
              style: fieldText,
              decoration: _decoration(),
            ),
            const SizedBox(height: 18),
            const _Label('태어난 시간'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _time,
                    enabled: !_timeUnknown,
                    keyboardType: TextInputType.datetime,
                    style: fieldText,
                    decoration: _decoration(),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _timeUnknown
                      ? const MutedText('시주 없음', fontSize: 14)
                      : const GanjiText('午시', fontSize: 15),
                ),
              ],
            ),
            CheckboxListTile(
              value: _timeUnknown,
              onChanged: (v) => setState(() => _timeUnknown = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: AppColors.gold,
              checkColor: AppColors.background,
              title: const Text(
                '시간을 몰라요 (시주 없이 봅니다)',
                style: TextStyle(fontSize: 14, color: AppColors.text),
              ),
            ),
            const SizedBox(height: 8),
            const _Label('태어난 곳'),
            DropdownButtonFormField<String>(
              initialValue: _place,
              dropdownColor: AppColors.surfaceHigh,
              style: fieldText,
              decoration: _decoration(),
              items: [
                for (final p in _places) DropdownMenuItem(value: p, child: Text(p)),
              ],
              onChanged: (v) => setState(() => _place = v ?? _place),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 16, color: AppColors.gold),
                  SizedBox(width: 8),
                  Expanded(
                    child: MutedText(
                      '출생 시각은 [보정 정책 확정 후 안내 문구: 표준시·경도·서머타임 반영 여부] 기준으로 계산합니다.',
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: '사주 보기',
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.loading),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
      ),
    );
  }
}

/// 한 줄에 같은 폭으로 놓인 선택 버튼들.
class _ChoiceRow<T> extends StatelessWidget {
  const _ChoiceRow({
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final List<T> values;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < values.length; i++) {
      final v = values[i];
      final on = v == selected;
      if (i > 0) children.add(const SizedBox(width: 8));
      children.add(
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: () => onSelected(v),
              style: OutlinedButton.styleFrom(
                backgroundColor: on ? AppColors.surfaceHigh : AppColors.surface,
                foregroundColor: on ? AppColors.gold : AppColors.text,
                side: BorderSide(
                  color: on ? AppColors.gold : AppColors.border,
                  width: on ? 1.5 : 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.zero,
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: on ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
              child: Text(labelOf(v)),
            ),
          ),
        ),
      );
    }
    return Row(children: children);
  }
}
