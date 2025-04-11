// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/etc/kr_localization.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'material_card.dart';

class ThemeSettingWidget extends StatelessWidget {
  const ThemeSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select((GlobalDisplayOptionBloc bloc) => bloc.state.themeMode);
    return MaterialCard(
        key: ValueKey(themeMode),
        title: '테마 설정',
        subTitle: themeDescriptionLocaleKR[themeMode] ?? '',
        isFoldable: false,
        children: [_ThemeSetting(), const SizedBox(height: 6)]);
  }
}

class _ThemeSetting extends StatelessWidget {
  const _ThemeSetting();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final themeMode =
        context.select((GlobalDisplayOptionBloc bloc) => bloc.state.themeMode);

    return Container(
        color: colorScheme.surfaceContainerHighest,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              SegmentedButton<ThemeMode>(
                segments: <ButtonSegment<ThemeMode>>[
                  ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      label: Text(themeLocaleKR[ThemeMode.system]!,
                          style: textTheme.labelMedium),
                      icon: const Icon(Icons.auto_mode)),
                  ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      label: Text(themeLocaleKR[ThemeMode.light]!,
                          style: textTheme.labelMedium),
                      icon: const Icon(Icons.light_mode)),
                  ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      label: Text(themeLocaleKR[ThemeMode.dark]!,
                          style: textTheme.labelMedium),
                      icon: const Icon(Icons.dark_mode)),
                ],
                selected: <ThemeMode>{themeMode},
                onSelectionChanged: (Set<ThemeMode> selectedTheme) {
                  switch (selectedTheme.first) {
                    case ThemeMode.system:
                      context
                          .read<GlobalDisplayOptionBloc>()
                          .add(SetSystemTheme());
                      break;
                    case ThemeMode.light:
                      context
                          .read<GlobalDisplayOptionBloc>()
                          .add(SetLightTheme());
                      break;
                    case ThemeMode.dark:
                      context
                          .read<GlobalDisplayOptionBloc>()
                          .add(SetDarkTheme());
                      break;
                  }
                },
              )
            ])));
  }
}
