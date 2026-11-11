import 'package:flutter/material.dart';

import '../app/theme.dart';

/// 테두리가 있는 어두운 카드. [onTap]이 있으면 눌림 효과가 생깁니다.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.onTap,
    this.highlight = false,
    this.radius = 16,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final VoidCallback? onTap;

  /// 금색 테두리로 강조합니다.
  final bool highlight;
  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: highlight ? AppColors.surfaceAccent : AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: highlight ? AppColors.gold : AppColors.border,
          width: highlight ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// '무료', '유료' 같은 작은 알약 모양 태그.
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    required this.foreground,
    required this.background,
  });

  const TagChip.free({super.key})
      : label = '무료',
        foreground = AppColors.free,
        background = AppColors.freeBg;

  const TagChip.paid({super.key})
      : label = '유료',
        foreground = AppColors.paid,
        background = AppColors.paidBg;

  final String label;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}
