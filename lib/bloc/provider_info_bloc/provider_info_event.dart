import 'package:equatable/equatable.dart';

abstract class ProviderInfoEvent extends Equatable {
  const ProviderInfoEvent();

  @override
  List<Object?> get props => [];
}

class LoadProviderInfo extends ProviderInfoEvent {}

class ToggleEditMode extends ProviderInfoEvent {}

class ToggleContactEditMode extends ProviderInfoEvent {}

class UpdateProviderInfo extends ProviderInfoEvent {
  final Map<String, dynamic> updatedInfo;

  const UpdateProviderInfo(this.updatedInfo);

  @override
  List<Object?> get props => [updatedInfo];
}

class PickTimeEvent extends ProviderInfoEvent {
  final String day;
  final bool isStart;
  final String time;

  const PickTimeEvent(this.day, this.isStart, this.time);

  @override
  List<Object?> get props => [day, isStart, time];
}
