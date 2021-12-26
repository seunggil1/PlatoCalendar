enum BuildType {debug, release}

class Appinfo{
  /// release, debug 여부 표시
  /// debug 모드일때 오류, 백그라운드 동기화를 상단 알림으로 표시함.
  static BuildType buildType = BuildType.debug;

  /// App build 날짜
  static double version = 2021225;
}