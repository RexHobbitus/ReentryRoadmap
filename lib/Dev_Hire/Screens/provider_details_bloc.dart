import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProviderDetailsEvent {}

class ChangeTabEvent extends ProviderDetailsEvent {
  final int index;

  ChangeTabEvent(this.index);
}

// States
abstract class ProviderDetailsState {}

class ProviderDetailsInitial extends ProviderDetailsState {
  final int selectedIndex;

  ProviderDetailsInitial({this.selectedIndex = 0}); // Default to index 0
}

// Bloc
class ProviderDetailsBloc extends Bloc<ProviderDetailsEvent, ProviderDetailsState> {
  ProviderDetailsBloc() : super(ProviderDetailsInitial()) {
    on<ChangeTabEvent>((event, emit) {
      // Emit a new state with the updated selected index
      emit(ProviderDetailsInitial(selectedIndex: event.index));
    });
  }
}
