import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reentry_roadmap/core/utils/pref_utils.dart';
import 'provider_info_event.dart';
import 'provider_info_state.dart';

class ProviderInfoBloc extends Bloc<ProviderInfoEvent, ProviderInfoState> {
  ProviderInfoBloc() : super(ProviderInfoState(providerInfo: {})) {
    on<LoadProviderInfo>(_loadProviderInfo);
    on<ToggleEditMode>(_toggleEditMode);
    on<ToggleContactEditMode>(_toggleContactEditMode);
    on<UpdateProviderInfo>(_updateProviderInfo);
    on<PickTimeEvent>(_pickTime);
  }

  Future<void> _loadProviderInfo(
      LoadProviderInfo event, Emitter<ProviderInfoState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      String userId = PrefUtil.getString(PrefUtil.userId);
      final doc = await FirebaseFirestore.instance
          .collection('ProviderPersonalInfo')
          .doc(userId.isNotEmpty ? userId : "Not")
          .get();
      if (doc.exists) {
        emit(state.copyWith(
          providerInfo: doc.data()!,
          isLoading: false,
          hasError: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false, hasError: false));
      }
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  void _toggleEditMode(ToggleEditMode event, Emitter<ProviderInfoState> emit) {
    // Check if the provider ID exists using PrefUtil
    String userId = PrefUtil.getString(PrefUtil.userId);

    if (userId.isEmpty) {
      // Show a toast message if the provider does not exist
      Fluttertoast.showToast(
        msg: "Provider does not exist. Please register first.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // Toggle the edit mode if the provider exists
      bool newEditModeState = !state.isEditMode;
      emit(state.copyWith(isEditMode: newEditModeState));

      // Show a toast message indicating the current edit mode status
      Fluttertoast.showToast(
        msg: newEditModeState ? "Edit mode enabled" : "Edit mode disabled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _toggleContactEditMode(
      ToggleContactEditMode event, Emitter<ProviderInfoState> emit) {
    emit(state.copyWith(isContactEditMode: !state.isContactEditMode));
  }

  Future<void> _updateProviderInfo(
      UpdateProviderInfo event, Emitter<ProviderInfoState> emit) async {
    String userId = PrefUtil.getString(PrefUtil.userId);
    if (userId != "") {
      await FirebaseFirestore.instance
          .collection('ProviderPersonalInfo')
          .doc(userId)
          .set(event.updatedInfo);
    }

    emit(state.copyWith(providerInfo: event.updatedInfo, isEditMode: false));
  }

  void _pickTime(PickTimeEvent event, Emitter<ProviderInfoState> emit) {
    final updatedHours =
        Map<String, dynamic>.from(state.providerInfo['operatingHours'] ?? {});
    updatedHours[event.day] = {
      ...updatedHours[event.day] ?? {},
      event.isStart ? 'start' : 'end': event.time,
    };

    emit(state.copyWith(providerInfo: {
      ...state.providerInfo,
      'operatingHours': updatedHours,
    }));
  }
}
