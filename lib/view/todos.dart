import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plato_calendar/view_model/view_model.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final platoThemeCubit = context.read<PlatoThemeCubit>();

    return Row(
      children: [
        TextButton(onPressed: platoThemeCubit.setLightTheme, child: const Text('set light')),
        TextButton(onPressed: platoThemeCubit.setDarkTheme, child: const Text('set dark'))
      ],
    );
    // return BlocProvider(
  }
}

// class PlatoCalendar extends StatelessWidget {
//   const PlatoCalendar({super.key});
  
  
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
