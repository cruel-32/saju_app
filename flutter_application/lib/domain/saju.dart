/// 사주 표시용 기본 모델.
///
/// 지금은 화면을 그리기 위한 최소 구조입니다. 만세력 엔진을 만들면
/// 엔진이 이 모델(또는 확장한 모델)을 채워 돌려주게 됩니다.
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

/// 기둥 하나 (예: 일주 甲寅).
class Pillar {
  const Pillar({
    required this.label,
    required this.stem,
    required this.branch,
    this.isDay = false,
  });

  /// '庚午' 같은 두 글자로 만듭니다.
  factory Pillar.of(String label, String ganji, {bool isDay = false}) {
    if (ganji.length != 2) {
      throw ArgumentError.value(ganji, 'ganji', '두 글자여야 합니다');
    }
    return Pillar(
      label: label,
      stem: Ganji.stem(ganji[0]),
      branch: Ganji.branch(ganji[1]),
      isDay: isDay,
    );
  }

  final String label;
  final Ganji stem;
  final Ganji branch;

  /// 일주(=나) 여부.
  final bool isDay;

  String get hanja => '${stem.hanja}${branch.hanja}';
  String get hangul => '${stem.hangul}${branch.hangul}';
}

class SajuChart {
  const SajuChart({
    required this.name,
    required this.birthSummary,
    required this.pillars,
    required this.gyeokName,
    required this.gyeokHanja,
    required this.isGyeokSample,
    required this.currentLuck,
  });

  final String name;
  final String birthSummary;

  /// 화면 표시 순서: 시주, 일주, 월주, 년주.
  final List<Pillar> pillars;

  final String gyeokName;
  final String gyeokHanja;

  /// 격 판정 규칙이 확정되기 전의 예시 값이면 true.
  final bool isGyeokSample;

  /// 현재 대운 간지 (예: 甲辰).
  final String currentLuck;
}
