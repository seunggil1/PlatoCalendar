import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum SelectedTab { calendar, todos }

final class TabState extends Equatable {
  const TabState({
    this.tab = SelectedTab.calendar,
  });

  final SelectedTab tab;

  @override
  List<Object> get props => [tab];
}

class BottomNavigationCubit extends Cubit<TabState> {
  BottomNavigationCubit() : super(const TabState());

  void setTab(SelectedTab tab) => emit(TabState(tab: tab));
}