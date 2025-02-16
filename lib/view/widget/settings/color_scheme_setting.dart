import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/etc/theme_seed_color.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'material_card.dart';

class ColorSchemeSettingWidget extends StatelessWidget {
  const ColorSchemeSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSeedColorIndex = context.select(
        (GlobalDisplayOptionBloc bloc) => bloc.state.themeSeedColorIndex);

    return MaterialCard(
        title: '테마 색상 선택',
        subTitle: '앱의 테마 색상을 선택합니다.',
        isFoldable: false,
        children: [
          _ColorSchemeSettingWidget(key: ValueKey(themeSeedColorIndex)),
          const SizedBox(height: 6),
        ]);
  }
}

class _ColorSchemeSettingWidget extends StatelessWidget {
  const _ColorSchemeSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final globalDisplayOptionBloc = context.read<GlobalDisplayOptionBloc>();
    final themeSeedColorIndex =
        globalDisplayOptionBloc.state.themeSeedColorIndex;

    return Wrap(
        children: themeSeedColors.mapIndexed((index, color) {
      return GestureDetector(
        onTap: () {
          globalDisplayOptionBloc.add(ChangeThemeSeedColor(index));
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          width: 20.sp,
          height: 20.sp,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              if (themeSeedColorIndex == index)
                Icon(
                  Icons.check,
                  color: colorScheme.onError,
                  size: 19.sp,
                ),
            ],
          ),
        ),
      );
    }).toList());
  }
}
