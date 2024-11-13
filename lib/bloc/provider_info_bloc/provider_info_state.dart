// provider_info_state.dart
import 'package:equatable/equatable.dart';

class ProviderInfoState extends Equatable {
  final Map<String, dynamic> providerInfo;
  final bool isEditMode;
  final bool isContactEditMode;
  final bool isLoading;
  final bool hasError;

  const ProviderInfoState({
    required this.providerInfo,
    this.isEditMode = false,
    this.isContactEditMode = false,
    this.isLoading = false,
    this.hasError = false,
  });

  ProviderInfoState copyWith({
    Map<String, dynamic>? providerInfo,
    bool? isEditMode,
    bool? isContactEditMode,
    bool? isLoading,
    bool? hasError,
  }) {
    return ProviderInfoState(
      providerInfo: providerInfo ?? this.providerInfo,
      isEditMode: isEditMode ?? this.isEditMode,
      isContactEditMode: isContactEditMode ?? this.isContactEditMode,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props =>
      [providerInfo, isEditMode, isLoading, hasError, isContactEditMode];
}
