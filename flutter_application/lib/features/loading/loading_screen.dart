import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../widgets/common.dart';

/// 만세력 계산 중 화면.
///
/// 지금은 0.9초마다 단계를 넘기는 연출입니다.
/// 엔진이 생기면 실제 계산 진행 상황에 맞춰 단계를 넘깁니다.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  static const _steps = [
    '출생 시각 보정',
    '절입 시각 확인 · 대설 12월 7일',
    '네 기둥 계산',
    '대운 순서와 시작 시점 계산',
    '해석 데이터 불러오기',
  ];

  /// 시·일·월·년 순서.
  static const _pillars = ['庚午', '甲寅', '己亥', '辛酉'];

  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();

  Timer? _timer;
  int _done = 0;

  bool get _finished => _done >= _steps.length;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 900), (t) {
      if (!mounted) return;
      setState(() => _done++);
      if (_finished) {
        t.cancel();
        _spin.stop();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showPillars = _done >= 3;
    final progress = _done / _steps.length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 72, 28, 32),
          child: Column(
            children: [
              SizedBox(
                width: 168,
                height: 168,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotationTransition(
                      turns: _spin,
                      child: const SizedBox(
                        width: 156,
                        height: 156,
                        child: CircularProgressIndicator(
                          value: 0.25,
                          strokeWidth: 2.5,
                          color: AppColors.gold,
                          backgroundColor: AppColors.border,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final p in _pillars)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: showPillars
                                ? GanjiText(
                                    '${p[0]}\n${p[1]}',
                                    fontSize: 22,
                                  )
                                : const Text(
                                    '·\n·',
                                    style: TextStyle(
                                      fontSize: 22,
                                      height: 1.3,
                                      color: AppColors.border,
                                    ),
                                  ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                '만세력을 계산하고 있어요',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              const MutedText('1981년 12월 2일 12시 30분 · 여성', fontSize: 14),
              const SizedBox(height: 36),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: progress),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    color: AppColors.gold,
                    backgroundColor: AppColors.surfaceHigh,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              for (var i = 0; i < _steps.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _StepRow(
                    index: i,
                    label: _steps[i],
                    state: i < _done
                        ? _StepState.done
                        : i == _done
                            ? _StepState.now
                            : _StepState.waiting,
                  ),
                ),
              const SizedBox(height: 16),
              if (_finished)
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: '결과 보기',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _StepState { done, now, waiting }

class _StepRow extends StatelessWidget {
  const _StepRow({required this.index, required this.label, required this.state});

  final int index;
  final String label;
  final _StepState state;

  @override
  Widget build(BuildContext context) {
    final (Color? fill, Color border, Color fg) = switch (state) {
      _StepState.done => (AppColors.gold, AppColors.gold, AppColors.background),
      _StepState.now => (null, AppColors.gold, AppColors.gold),
      _StepState.waiting => (null, AppColors.textMuted, AppColors.textMuted),
    };
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fill,
            shape: BoxShape.circle,
            border: Border.all(color: border, width: 1.5),
          ),
          child: state == _StepState.done
              ? Icon(Icons.check, size: 14, color: fg)
              : Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: fg,
                  ),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: state == _StepState.waiting
                  ? AppColors.textMuted
                  : AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
