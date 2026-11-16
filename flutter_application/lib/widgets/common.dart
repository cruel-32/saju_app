import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../domain/saju.dart';

/// 하위 화면 공통 상단 바.
AppBar buildSubAppBar(String title, {List<Widget>? actions}) {
  return AppBar(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.text,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleSpacing: 0,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    ),
    actions: actions,
  );
}

/// 한자 간지 글자를 오행 색으로 그립니다. '甲辰'처럼 여러 글자도 됩니다.
class GanjiText extends StatelessWidget {
  const GanjiText(
    this.text, {
    super.key,
    this.fontSize = 24,
    this.height = 1.3,
  });

  final String text;
  final double fontSize;
  final double height;

  static Color _colorOf(String ch) {
    final g = Ganji.find(ch);
    return g == null ? AppColors.text : AppColors.ohaeng(g.ohaeng);
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for (final ch in text.split(''))
            TextSpan(
              text: ch,
              style: TextStyle(
                color: _colorOf(ch),
              ),
            ),
        ],
      ),
      style: TextStyle(
        fontSize: fontSize,
        height: height,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// 섹션 제목.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// 흐린 보조 문구.
class MutedText extends StatelessWidget {
  const MutedText(this.text, {super.key, this.fontSize = 13, this.height = 1.55});

  final String text;
  final double fontSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        height: height,
        color: AppColors.textMuted,
      ),
    );
  }
}

/// 작은 회색 상자 라벨 (예: 십신 편관).
class InfoChip extends StatelessWidget {
  const InfoChip(this.text, {super.key, this.radius = 6, this.fontSize = 12});

  final String text;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: AppColors.text),
      ),
    );
  }
}

/// 금색 채움 버튼 (화면 하단 주요 동작).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

/// 금색 테두리 버튼.
class OutlineGoldButton extends StatelessWidget {
  const OutlineGoldButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.gold,
          side: const BorderSide(color: AppColors.gold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

/// 유료 분석 화면 하단의 '이 풀이의 근거 (계산값)' 상자.
/// 해석 문장이 어떤 계산값에서 나왔는지 보여 줍니다.
class BasisBox extends StatelessWidget {
  const BasisBox({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.navBar,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MutedText('이 풀이의 근거 (계산값)', fontSize: 11),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [for (final item in items) InfoChip(item)],
          ),
        ],
      ),
    );
  }
}

/// 해석 문장이 들어갈 자리 (전문가 집필 전).
class PlaceholderParagraph extends StatelessWidget {
  const PlaceholderParagraph(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return MutedText(text, fontSize: 14, height: 1.65);
  }
}
