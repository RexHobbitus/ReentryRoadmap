import 'package:equatable/equatable.dart';

import 'bottom_nav_initial_params.dart';

class BottomNavState extends Equatable{
  final bool loading;
  final int currentIndex;

  const BottomNavState({required this.loading, required this.currentIndex});

  factory BottomNavState.initial() =>
      const BottomNavState(loading: false, currentIndex: 0);

  BottomNavState copyWith({bool? loading, int? currentIndex}) => BottomNavState(
    loading: loading ?? this.loading,
    currentIndex: currentIndex ?? this.currentIndex,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [loading,currentIndex];
}