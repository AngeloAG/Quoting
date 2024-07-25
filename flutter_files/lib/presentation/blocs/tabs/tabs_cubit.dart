import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(const TabsState());

  void setTabIndex(int index) => emit(state.copyWith(tabIndex: () => index));
}
