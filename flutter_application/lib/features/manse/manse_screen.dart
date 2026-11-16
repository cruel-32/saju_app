import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/saju.dart';
import '../../widgets/common.dart';
import '../../widgets/surface_card.dart';

/// 나의 만세력: 원국 표와 합·충, 오행, 공망·귀인.
class ManseScreen extends StatefulWidget {
  const ManseScreen({super.key, required this.chart, this.asTab = false});

  final SajuChart chart;

  /// 하단 탭 안에 들어갈 때 true (뒤로 버튼 없음).
  final bool asTab;

  @override
  State<ManseScreen> createState() => _ManseScreenState();
}

enum _ManseTab { relations, ohaeng, etc }

class _ManseScreenState extends State<ManseScreen> {
  _ManseTab _tab = _ManseTab.relations;

  @override
  Widget build(BuildContext context) {
    final chart = widget.chart;
    return Scaffold(
      appBar: buildSubAppBar('나의 만세력'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MutedText(chart.birthDetail, fontSize: 12),
                MutedText(chart.lunarDetail, fontSize: 12),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _ChartTable(pillars: chart.pillars),
          const SizedBox(height: 10),
          _TabSelector(
            selected: _tab,
            onSelected: (t) => setState(() => _tab = t),
          ),
          const SizedBox(height: 10),
          switch (_tab) {
            _ManseTab.relations => _RelationsCard(relations: chart.relations),
            _ManseTab.ohaeng => _OhaengCard(counts: chart.ohaengCount),
            _ManseTab.etc => _EtcCard(chart: chart),
          },
        ],
      ),
    );
  }
}

class _ChartTable extends StatelessWidget {
  const _ChartTable({required this.pillars});

  final List<Pillar> pillars;

  static const _label = TextStyle(fontSize: 11, color: AppColors.textMuted);
  static const _cell = TextStyle(fontSize: 12, color: AppColors.text);

  TableRow _textRow(String label, String Function(Pillar) value, {bool hanja = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(label, style: _label),
        ),
        for (final p in pillars)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              value(p),
              textAlign: TextAlign.center,
              style: _cell.copyWith(
                color: p.isDay && label == '십신' && value(p).contains('일간')
                    ? AppColors.gold
                    : AppColors.text,
                letterSpacing: hanja ? 1 : null,
              ),
            ),
          ),
      ],
    );
  }

  TableRow _glyphRow(String label, Ganji Function(Pillar) glyph) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(label, style: _label),
        ),
        for (final p in pillars)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(8),
                border: p.isDay && label == '천간'
                    ? Border.all(color: AppColors.gold, width: 1.5)
                    : null,
              ),
              child: GanjiText(glyph(p).hanja, fontSize: 24),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Table(
        columnWidths: const {0: FixedColumnWidth(46)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              const SizedBox.shrink(),
              for (final p in pillars)
                Text(
                  p.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: p.isDay ? FontWeight.w700 : FontWeight.w400,
                    color: p.isDay ? AppColors.gold : AppColors.textMuted,
                  ),
                ),
            ],
          ),
          _textRow('십신', (p) => p.stemTenGod),
          _glyphRow('천간', (p) => p.stem),
          _glyphRow('지지', (p) => p.branch),
          _textRow('십신', (p) => p.branchTenGod),
          _textRow('지장간', (p) => p.hiddenStems, hanja: true),
          _textRow('12운성', (p) => p.twelveStage),
          _textRow('납음', (p) => p.napeum),
          _textRow('12신살', (p) => p.sinsal),
        ],
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector({required this.selected, required this.onSelected});

  final _ManseTab selected;
  final ValueChanged<_ManseTab> onSelected;

  static const _labels = {
    _ManseTab.relations: '합·충',
    _ManseTab.ohaeng: '오행',
    _ManseTab.etc: '공망·귀인',
  };

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (final t in _ManseTab.values) {
      final on = t == selected;
      if (children.isNotEmpty) children.add(const SizedBox(width: 6));
      children.add(
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextButton(
              onPressed: () => onSelected(t),
              style: TextButton.styleFrom(
                backgroundColor: on ? AppColors.gold : AppColors.surface,
                foregroundColor: on ? AppColors.background : AppColors.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: on ? AppColors.gold : AppColors.border),
                ),
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: on ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
              child: Text(_labels[t]!),
            ),
          ),
        ),
      );
    }
    return Row(children: children);
  }
}

class _RelationsCard extends StatelessWidget {
  const _RelationsCard({required this.relations});

  final List<Relation> relations;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        children: [
          for (final r in relations)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(r.pair, style: const TextStyle(fontSize: 13, color: AppColors.text)),
                  const Spacer(),
                  Text(
                    r.name,
                    style: TextStyle(
                      fontSize: 13,
                      color: switch (r.tone) {
                        RelationTone.harmony => AppColors.ohaeng(Ohaeng.wood),
                        RelationTone.clash => AppColors.ohaeng(Ohaeng.fire),
                        RelationTone.neutral => AppColors.ohaeng(Ohaeng.earth),
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _OhaengCard extends StatelessWidget {
  const _OhaengCard({required this.counts});

  final Map<Ohaeng, int> counts;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final o in Ohaeng.values)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHigh,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          o.hangul,
                          style: TextStyle(fontSize: 12, color: AppColors.ohaeng(o)),
                        ),
                        Text(
                          '${counts[o] ?? 0}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          const MutedText('원국 8글자 기준 · 지장간 미포함', fontSize: 12),
        ],
      ),
    );
  }
}

class _EtcCard extends StatelessWidget {
  const _EtcCard({required this.chart});

  final SajuChart chart;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('공망', chart.gongmang),
      ('천을귀인', chart.cheoneul),
      ('월령(사령)', chart.wolryeong),
      ('대운', '대운수 ${chart.luckStartAge} · ${chart.luckForward ? '순행' : '역행'}'),
    ];
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        children: [
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  MutedText(row.$1, fontSize: 13),
                  const Spacer(),
                  Text(row.$2, style: const TextStyle(fontSize: 13, color: AppColors.text)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
