part of 'tabs_cubit.dart';

final class TabsState extends Equatable {
  final int tabIndex;

  const TabsState({
    this.tabIndex = 0,
  });

  TabsState copyWith({int Function()? tabIndex}) {
    return TabsState(
      tabIndex: tabIndex != null ? tabIndex() : this.tabIndex,
    );
  }

  @override
  List<Object> get props => [tabIndex];
}
