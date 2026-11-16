/// 사주 표시용 모델.
///
/// 지금은 화면을 그리기 위한 구조입니다. 만세력 엔진을 만들면
/// 엔진이 이 모델을 채워 돌려주게 됩니다.
library;

enum Ohaeng {
  wood('목', '木'),
  fire('화', '火'),
  earth('토', '土'),
  metal('금', '金'),
  water('수', '水');

  const Ohaeng(this.hangul, this.hanja);

  final String hangul;
  final String hanja;
}

/// 천간 또는 지지 한 글자.
class Ganji {
  const Ganji(this.hanja, this.hangul, this.ohaeng, {required this.isYang});

  final String hanja;
  final String hangul;
  final Ohaeng ohaeng;
  final bool isYang;

  static Ganji stem(String hanja) => stems.firstWhere(
        (g) => g.hanja == hanja,
        orElse: () => throw ArgumentError.value(hanja, 'hanja', '천간이 아닙니다'),
      );

  static Ganji branch(String hanja) => branches.firstWhere(
        (g) => g.hanja == hanja,
        orElse: () => throw ArgumentError.value(hanja, 'hanja', '지지가 아닙니다'),
      );

  /// 천간·지지 어느 쪽이든 찾습니다. 없으면 null.
  static Ganji? find(String hanja) {
    for (final g in stems) {
      if (g.hanja == hanja) return g;
    }
    for (final g in branches) {
      if (g.hanja == hanja) return g;
    }
    return null;
  }
}

/// 천간 10개 (인덱스 0 = 甲).
const List<Ganji> stems = [
  Ganji('甲', '갑', Ohaeng.wood, isYang: true),
  Ganji('乙', '을', Ohaeng.wood, isYang: false),
  Ganji('丙', '병', Ohaeng.fire, isYang: true),
  Ganji('丁', '정', Ohaeng.fire, isYang: false),
  Ganji('戊', '무', Ohaeng.earth, isYang: true),
  Ganji('己', '기', Ohaeng.earth, isYang: false),
  Ganji('庚', '경', Ohaeng.metal, isYang: true),
  Ganji('辛', '신', Ohaeng.metal, isYang: false),
  Ganji('壬', '임', Ohaeng.water, isYang: true),
  Ganji('癸', '계', Ohaeng.water, isYang: false),
];

/// 지지 12개 (인덱스 0 = 子).
const List<Ganji> branches = [
  Ganji('子', '자', Ohaeng.water, isYang: true),
  Ganji('丑', '축', Ohaeng.earth, isYang: false),
  Ganji('寅', '인', Ohaeng.wood, isYang: true),
  Ganji('卯', '묘', Ohaeng.wood, isYang: false),
  Ganji('辰', '진', Ohaeng.earth, isYang: true),
  Ganji('巳', '사', Ohaeng.fire, isYang: false),
  Ganji('午', '오', Ohaeng.fire, isYang: true),
  Ganji('未', '미', Ohaeng.earth, isYang: false),
  Ganji('申', '신', Ohaeng.metal, isYang: true),
  Ganji('酉', '유', Ohaeng.metal, isYang: false),
  Ganji('戌', '술', Ohaeng.earth, isYang: true),
  Ganji('亥', '해', Ohaeng.water, isYang: false),
];

/// 기둥 하나 (예: 일주 甲寅)와 그 기둥에 딸린 계산값.
class Pillar {
  const Pillar({
    required this.label,
    required this.stem,
    required this.branch,
    this.isDay = false,
    this.stemTenGod = '',
    this.branchTenGod = '',
    this.hiddenStems = '',
    this.twelveStage = '',
    this.napeum = '',
    this.sinsal = '',
  });

  /// '庚午' 같은 두 글자로 만듭니다.
  factory Pillar.of(
    String label,
    String ganji, {
    bool isDay = false,
    String stemTenGod = '',
    String branchTenGod = '',
    String hiddenStems = '',
    String twelveStage = '',
    String napeum = '',
    String sinsal = '',
  }) {
    if (ganji.length != 2) {
      throw ArgumentError.value(ganji, 'ganji', '두 글자여야 합니다');
    }
    return Pillar(
      label: label,
      stem: Ganji.stem(ganji[0]),
      branch: Ganji.branch(ganji[1]),
      isDay: isDay,
      stemTenGod: stemTenGod,
      branchTenGod: branchTenGod,
      hiddenStems: hiddenStems,
      twelveStage: twelveStage,
      napeum: napeum,
      sinsal: sinsal,
    );
  }

  final String label;
  final Ganji stem;
  final Ganji branch;

  /// 일주(=나) 여부.
  final bool isDay;

  final String stemTenGod;
  final String branchTenGod;
  final String hiddenStems;
  final String twelveStage;
  final String napeum;

  /// 12신살 (년지 기준).
  final String sinsal;

  String get hanja => '${stem.hanja}${branch.hanja}';
  String get hangul => '${stem.hangul}${branch.hangul}';
}

enum RelationTone { harmony, clash, neutral }

/// 글자 사이의 관계 (합·충·형·파·해·원진 등).
class Relation {
  const Relation(this.pair, this.name, this.tone);

  final String pair;
  final String name;
  final RelationTone tone;
}

/// 십성 묶음별 개수 (비겁·식상·재성·관성·인성).
class TenGodGroup {
  const TenGodGroup(this.name, this.count);

  final String name;
  final int count;
}

/// 대운 한 구간.
class LuckPeriod {
  const LuckPeriod({
    required this.ganji,
    required this.startAge,
    required this.tenGods,
    required this.stage,
    required this.years,
    this.isCurrent = false,
  });

  final String ganji;
  final int startAge;
  final String tenGods;
  final String stage;
  final String years;
  final bool isCurrent;
}

/// 세운 (해마다의 간지).
class YearLuck {
  const YearLuck(this.year, this.ganji, this.tenGods, {this.isCurrent = false});

  final int year;
  final String ganji;
  final String tenGods;
  final bool isCurrent;
}

class SajuChart {
  const SajuChart({
    required this.name,
    required this.birthSummary,
    required this.birthDetail,
    required this.lunarDetail,
    required this.pillars,
    required this.gyeokName,
    required this.gyeokHanja,
    required this.isGyeokSample,
    required this.useGod,
    required this.ohaengCount,
    required this.tenGodGroups,
    required this.relations,
    required this.gongmang,
    required this.cheoneul,
    required this.wolryeong,
    required this.luckStartAge,
    required this.luckForward,
    required this.luckPeriods,
    required this.yearLucks,
  });

  final String name;

  /// 홈 카드용 한 줄 (예: 양 1981.12.02 12:30 · 여).
  final String birthSummary;
  final String birthDetail;
  final String lunarDetail;

  /// 화면 표시 순서: 시주, 일주, 월주, 년주.
  final List<Pillar> pillars;

  final String gyeokName;
  final String gyeokHanja;

  /// 격 판정 규칙이 확정되기 전의 예시 값이면 true.
  final bool isGyeokSample;

  /// 용신 (예: 壬水).
  final String useGod;

  final Map<Ohaeng, int> ohaengCount;
  final List<TenGodGroup> tenGodGroups;
  final List<Relation> relations;

  final String gongmang;
  final String cheoneul;
  final String wolryeong;

  final int luckStartAge;
  final bool luckForward;
  final List<LuckPeriod> luckPeriods;
  final List<YearLuck> yearLucks;

  /// 현재 대운.
  LuckPeriod get currentLuckPeriod => luckPeriods.firstWhere(
        (p) => p.isCurrent,
        orElse: () => luckPeriods.first,
      );

  /// 현재 대운 간지 (예: 甲辰).
  String get currentLuck => currentLuckPeriod.ganji;
}
