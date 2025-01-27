library;

export './debug_setting.dart';
export './syncfusion_calendar.dart';
export './task_check_list.dart';
export './main_default.dart';
export './main_wide.dart';

// Material3 Widgets
// https://docs.flutter.dev/ui/widgets/material
// https://docs.flutter.dev/ui/design/material

/// Color scheme guide
/// 	•	Theme.of(context).colorScheme의 하위 값으로 접근 가능
///
/// 	•	primary
///   앱의 대표 색상(브랜드 컬러 등)으로 사용됩니다. 버튼, 토글, 액션 요소 등에 자주 쓰이는 주요 포인트 컬러입니다.
/// 	•	onPrimary
///   primary 색 위에 표시될 전경(텍스트·아이콘 등) 컬러입니다. 예를 들어 ElevatedButton의 배경이 primary일 때, 글씨 색상은 onPrimary를 사용하면 가독성을 확보할 수 있습니다.
/// 	•	secondary
///   보조 색상(secondary color)으로, primary 다음으로 자주 사용하는 강조 컬러입니다. 예: 일부 포인트나 구분선, 토글 버튼 등에 활용.
/// 	•	onSecondary
///   secondary 색 위에 표시될 전경 컬러입니다.
/// 	•	background
///   앱 전체의 배경 색상에 해당합니다. 스크롤 가능한 콘텐츠 뒤 배경(예: Scaffold 기본 배경)으로 주로 사용합니다.
/// 	•	onBackground
///   background 위에 표시될 전경 컬러입니다. 보통 텍스트 색 등으로 사용합니다.
/// 	•	surface
///   카드, 다이얼로그, 패널 등 “표면(Surface)”에 해당하는 영역의 배경색입니다.
/// 	•	onSurface
///   surface 위에 표시될 전경 컬러입니다. 보통 카드 위의 텍스트나 아이콘 등에 사용됩니다.
/// 	•	error
///   에러를 나타낼 때 사용하는 컬러입니다. 예: 폼 검증 실패 메시지, 에러 스낵바, 에러 아이콘 등에 사용.
/// 	•	onError
///   error 색 위에 표시될 전경 컬러입니다.
///
/// 	•	tertiary / onTertiary
///   3차 보조 색상. 좀 더 다양한 시각적 강조나 구분을 위해 사용됩니다.
/// 	•	tertiary: 3차 강조(보조)로 쓰는 색
/// 	•	onTertiary: 그 위에 표시될 전경 색
/// 	•	primaryContainer / onPrimaryContainer
///   primary 색상을 “컨테이너(배경)”로 확장한 색상. 카드 내부나 특별한 컴포넌트의 배경 등에 쓰일 수 있습니다.
/// 	•	primaryContainer: 컨테이너 배경용
/// 	•	onPrimaryContainer: 해당 배경 위 텍스트/아이콘 등 전경 색
/// 	•	secondaryContainer / onSecondaryContainer
///   secondary 색상의 컨테이너 버전.
/// 	•	secondaryContainer: 보조색 기반의 배경
/// 	•	onSecondaryContainer: 그 위 전경 색
/// 	•	tertiaryContainer / onTertiaryContainer
///   tertiary 색상의 컨테이너 버전.
/// 	•	tertiaryContainer
/// 	•	onTertiaryContainer
/// 	•	errorContainer / onErrorContainer
///   error 색상의 컨테이너 버전. 에러와 관련된 배경(알림 배너 등)에 사용.
/// 	•	surfaceContainerHighest / onSurfaceContainerHighest
///   기본 surface보다 변형된 배경 표면 색. 보다 미묘한 색 변화를 주고 싶을 때 쓸 수 있습니다.
/// 	•	inverseSurface / onInverseSurface
///   밝은 테마에서 어두운 표면, 혹은 어두운 테마에서 밝은 표면처럼, 기존 surface와 반대되는 명도/채도의 표면입니다. 스낵바, 다이얼로그, 툴팁 등에서 배경을 반전하는 UI 요소에 사용될 수 있습니다.
/// 	•	inversePrimary
///   primary 색상의 반전 버전. 동일 맥락에서 UI 일부를 반전시켜야 할 때 사용합니다.
/// 	•	outline / outlineVariant
///   윤곽선(아웃라인), 구분선 등에 쓰이는 색상들입니다. M3에서는 구분선 색도 배경과의 대비 등을 세심하게 설정합니다.
/// 	•	shadow
///   그림자(Shadow)에 사용될 컬러입니다.
/// 	•	scrim
///   배경을 흐리게 처리하는 스크림(Scrim) 영역에 사용되는 색상입니다. 예: 다이얼로그 뒤쪽, BottomSheet 배경 흐림 등.
/// 	•	surfaceTint
///   M3에서 표면에 살짝 “tint” 효과를 주기 위한 색상입니다. 앱바 스크롤 효과, 표면 양감 표현 등에 사용됩니다.
///
