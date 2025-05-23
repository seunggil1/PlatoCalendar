library;

export './main_default.dart';
export './main_wide.dart';
export './setting.dart';
export './syncfusion_calendar.dart';
export './todo_list.dart';

// Material3 Widgets
// https://docs.flutter.dev/ui/widgets/material
// https://docs.flutter.dev/ui/design/material

// Color scheme guide
// 	•	Theme.of(context).colorScheme의 하위 값으로 접근 가능
// primary / onPrimary
// •	primary: 앱의 주 브랜드/테마 컬러(가장 핵심적인 강조색).
// •	onPrimary: primary 배경 위에 놓일 텍스트나 아이콘 색.
//
// secondary / onSecondary
// •	secondary: 보조 강조색(주로 UI의 일부 요소, 예: FAB, 스위치 토글 등).
// •	onSecondary: secondary 배경 위에 놓일 텍스트나 아이콘 색.
//
// tertiary / onTertiary
// •	tertiary: 1차/2차 색상과는 다른 보조 색, 디자인 폭을 넓히기 위해 사용.
// •	onTertiary: tertiary 위에 놓이는 텍스트나 아이콘 색.
//
// error / onError
// •	error: 오류나 경고 등을 표시할 때 사용되는 색상(빨간 계열).
// •	onError: error 위에 놓이는 텍스트, 아이콘 색.
//
// surface / onSurface
// •	surface: 카드, 시트(sheet), 모달 같은 UI 표면의 기본 배경 색.
// •	onSurface: surface 위에 놓이는 텍스트나 아이콘 색.
//
// outline
// •	테두리나 구분선 등을 표시할 때 사용하는 컬러. (M3에서는 outlineVariant도 추가됨)
//
// shadow / scrim
// •	그림자(shadow)나, 뒤 배경을 흐리게 하는 스크림(scrim) 등에 쓰이는 색상.
//
// Container 관련 색상
//
// Material 3에서는 **“Container”**라는 개념으로,
// 기본 색과는 별도로 컨테이너 전용 색을 활용합니다.
// (예: “primaryContainer”는 “primary”보다 밝거나 어두운 톤으로 배경색을 변형하여 사용)
// •	primaryContainer / onPrimaryContainer
// •	primary와 연관된 컨테이너 배경, 그 위의 텍스트/아이콘.
// •	secondaryContainer / onSecondaryContainer
// •	secondary와 연관된 컨테이너 배경, 그 위의 텍스트/아이콘.
// •	tertiaryContainer / onTertiaryContainer
// •	tertiary와 연관된 컨테이너 배경, 그 위의 텍스트/아이콘.
// •	errorContainer / onErrorContainer
// •	error와 연관된 컨테이너 배경, 그 위의 텍스트/아이콘.
//
// 이들은 M3에서 “Filled” 컴포넌트 (예: FilledButton), 또는 카드/리스트 등
// 다양한 경우에 쓰여서 톤(tone)이 살짝 변형된 배경 색상을 표현합니다.
//
// •	onSurfaceVariant
// •	“surface” 위에 놓인 텍스트/아이콘 중, 기본 대비보다 살짝 ‘약한(variant)’ 색을 써야 할 때 사용.
// •	outlineVariant
// •	outline보다 톤이 약간 다르거나 부드러운 테두리를 표현할 때.
// •	inverseSurface / onInverseSurface
// •	어두운 화면(혹은 반대로 밝은 화면) 위에 반전된 색 조합으로 텍스트나 아이콘을 표시할 때 활용.
// •	inversePrimary
// •	기본 배경과 반대 상황에서 primary 역할을 할 색을 지정.
// •	surfaceTint
// •	M3의 “surface tint overlay” 기능에 쓰이는 색상.
// •	표면(Material) 위에 살짝 깔리는 오버레이 색을 결정.

// Surface 변형 색상들
//
// M3에서는 표면을 더 유연하게 표현하기 위해 다양한 “surface” 변형 컬러가 있습니다:
// •	surfaceDim / surfaceBright
// •	표면 색에 약간 어둡거나 밝은 톤을 적용할 때 사용.
// •	surfaceContainerLowest / surfaceContainerLow / surfaceContainer / surfaceContainerHigh / surfaceContainerHighest
// •	표면 레벨(깊이/표면 높이)에 따라 점진적으로 다른 톤을 주기 위한 컬러 계층.
// •	예: Card가 여러 겹 쌓일 때 가장 뒤쪽(최하위 레벨)부터 점점 더 밝거나 어두운 톤을 줄 수 있음.
//
// •	onSurfaceVariant
// •	“surface” 위에 놓인 텍스트/아이콘 중, 기본 대비보다 살짝 ‘약한(variant)’ 색을 써야 할 때 사용.
// •	outlineVariant
// •	outline보다 톤이 약간 다르거나 부드러운 테두리를 표현할 때.
// •	inverseSurface / onInverseSurface
// •	어두운 화면(혹은 반대로 밝은 화면) 위에 반전된 색 조합으로 텍스트나 아이콘을 표시할 때 활용.
// •	inversePrimary
// •	기본 배경과 반대 상황에서 primary 역할을 할 색을 지정.
// •	surfaceTint
// •	M3의 “surface tint overlay” 기능에 쓰이는 색상.
// •	표면(Material) 위에 살짝 깔리는 오버레이 색을 결정.
