import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/view_model.dart';

class DurationHeaderWidget extends StatelessWidget {
  final int index;
  final bool showToList;
  final String headerText;

  const DurationHeaderWidget(
      {super.key,
      required this.index,
      required this.showToList,
      required this.headerText});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
        margin: const EdgeInsets.all(5),
        // TODO : 현재 코드 구조에서 GestureDetector 필요 여부 체크 필요
        // child 없는 빈 Container도 터치 감지할 수 있게 하기 위해 설정
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final bloc = context.read<TodoListBloc>();
              bloc.add(ChangeTodoDisplayOption(index));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(headerText,
                    style: TextStyle(fontSize: 15, color: colorScheme.primary)),
                Expanded(child: Container()),
                showToList
                    ? Icon(Icons.keyboard_arrow_up_sharp,
                        color: colorScheme.primary, size: 27)
                    : Icon(Icons.keyboard_arrow_down_sharp,
                        color: colorScheme.primary, size: 27)
              ],
            )));
  }
}
