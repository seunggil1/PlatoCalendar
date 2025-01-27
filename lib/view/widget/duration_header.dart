import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/view_model.dart';

Widget getDurationHeaderWidget(
    BuildContext context, int index, bool showToList, String headerText) {
  final colorScheme = Theme.of(context).colorScheme;
  return Container(
      margin: const EdgeInsets.all(5),
      // TODO : 현재 코드 구조에서 GestureDetector 필요 여부 체크 필요
      // child 없는 빈 Container도 터치 감지할 수 있게 하기 위해 설정
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            final bloc = context.read<TaskCheckListBloc>();
            bloc.add(ChangeTaskCheckListDisplayOption(index));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(headerText, style: TextStyle(fontSize: 15)),
              Expanded(child: Container()),
              showToList
                  ? Icon(Icons.keyboard_arrow_down_sharp,
                      color: colorScheme.primary, size: 27)
                  : Icon(Icons.keyboard_arrow_up_sharp,
                      color: colorScheme.primary, size: 27)
            ],
          )));
}
