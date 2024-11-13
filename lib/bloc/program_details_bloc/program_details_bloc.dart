import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/models/item_selection_model.dart';
import 'program_details_event.dart';
import 'program_details_state.dart';

class ProgramDetailsBloc
    extends Bloc<ProgramDetailsEvent, ProgramDetailsState> {
  final FirebaseFirestore _firestore;

  ProgramDetailsBloc(this._firestore)
      : super(const ProgramDetailsState(
          selectedItems: {},
          selectedIndicesByCategory: {
            'education': null,
            'employment': null,
            'generalServices': null,
          },
          selectedCriteria: [null],
          data: [],
          selectionData: {},
        )) {
    on<LoadProgramDetails>(_onLoadProgramDetails);
    on<UpdateSelectedItems>(_onUpdateSelectedItems);
    on<UpdateCategorySelection>(_onUpdateCategorySelection);
    on<AddDropdownCriteria>(_onAddDropdownCriteria);
    on<SaveProgramDetails>(_onSaveProgramDetails);
    on<DeleteProgramDetails>(_onDeleteProgramDetails);
    on<UpdateProgramDetails>(_onUpdateProgramDetails);
    on<ToggleEditMode>(_onToggleEditMode);
    on<UpdateSelectedCriteria>(_onUpdateSelectedCriteria);
  }

  void _onLoadProgramDetails(
      LoadProgramDetails event, Emitter<ProgramDetailsState> emit) async {
    String userId = PrefUtil.getString(PrefUtil.userId);
    emit(state.copyWith(isLoading: true));
    final querySnapshot = await _firestore
        .collection('program_details')
        .where("userId", isEqualTo: userId)
        .get();
    List<Map<String, dynamic>> fetchedData = [];

    if (querySnapshot.docs.isNotEmpty) {
      fetchedData = querySnapshot.docs.map((doc) {
        final data = doc.data();

        // Process selectedItems
        List<dynamic>? selectedItemsDynamic = data['selectedItems'];
        List<int> selectedItems = [];
        if (selectedItemsDynamic != null) {
          selectedItems = selectedItemsDynamic.map((e) => e as int).toList();
        }
        data['selectedItems'] = selectedItems;

        // Process selectedIndicesByCategory
        Map<String, dynamic>? selectedIndicesByCategoryDynamic =
            data['selectedIndicesByCategory'];
        Map<String, int?> selectedIndicesByCategory = {};
        if (selectedIndicesByCategoryDynamic != null) {
          selectedIndicesByCategoryDynamic.forEach((key, value) {
            selectedIndicesByCategory[key] =
                value == null ? null : value as int;
          });
        } else {
          selectedIndicesByCategory = {
            'education': null,
            'employment': null,
            'generalServices': null,
          };
        }
        data['selectedIndicesByCategory'] = selectedIndicesByCategory;

        // Process selectedCriteria
        List<dynamic>? selectedCriteriaDynamic = data['selectedCriteria'];
        List<String?> selectedCriteria = [];
        if (selectedCriteriaDynamic != null) {
          selectedCriteria =
              selectedCriteriaDynamic.map((e) => e as String?).toList();
        } else {
          selectedCriteria = [];
        }
        data['selectedCriteria'] = selectedCriteria;

        data['documentId'] = doc.id; // Include document ID for updates/deletes
        return data;
      }).toList();
    }

    // Prepend the initial item to the fetched data
    final initialItem = {
      'selectedItems': [],
      'selectedIndicesByCategory': {
        'education': null,
        'employment': null,
        'generalServices': null,
      },
      'selectedCriteria': [],
    };

    final combinedData = [initialItem, ...fetchedData];

    emit(state.copyWith(data: combinedData, isLoading: false));
  }

  void _onUpdateSelectedItems(
      UpdateSelectedItems event, Emitter<ProgramDetailsState> emit) {
    // Create a copy of the data list
    final data = List<Map<String, dynamic>>.from(state.data!);

    // Get the specific item data based on the outer index
    final itemData = Map<String, dynamic>.from(data[event.outerIndex]);

    // Get the selected items for this specific data item
    final selectedItems = Set<int>.from(itemData['selectedItems'] ?? []);

    // Toggle the selection of the inner item
    if (selectedItems.contains(event.innerIndex)) {
      selectedItems.remove(event.innerIndex);
      log('Removed item at inner index ${event.innerIndex} from selected items.');
    } else {
      selectedItems.add(event.innerIndex);
      log('Added item at inner index ${event.innerIndex} to selected items.');
    }

    // Update the itemData with the new selectedItems
    itemData['selectedItems'] = selectedItems.toList();

    // Update the data list with the modified itemData
    data[event.outerIndex] = itemData;

    log('Updated data at outer index ${event.outerIndex} with new selected items.');

    // Emit the new state with the updated data
    emit(state.copyWith(data: data));
  }

  void _onUpdateCategorySelection(
      UpdateCategorySelection event, Emitter<ProgramDetailsState> emit) {
    // Create a copy of the data list
    final data = List<Map<String, dynamic>>.from(state.data!);

    // Get the specific item data based on the index
    final itemData = Map<String, dynamic>.from(data[event.index]);

    // Get the selectedIndicesByCategory for this specific data item
    final selectedIndicesByCategory =
        Map<String, int?>.from(itemData['selectedIndicesByCategory'] ??
            {
              'education': null,
              'employment': null,
              'generalServices': null,
            });

    // Update the selectedIndicesByCategory
    selectedIndicesByCategory[event.categoryKey] = event.itemIndex;

    log('Updated category selection for index ${event.index}, category ${event.categoryKey}, itemIndex ${event.itemIndex}');

    // Update the itemData with the new selectedIndicesByCategory
    itemData['selectedIndicesByCategory'] = selectedIndicesByCategory;

    // Update the data list with the modified itemData
    data[event.index] = itemData;

    // Emit the new state with the updated data
    emit(state.copyWith(data: data));
  }

  void _onUpdateSelectedCriteria(
      UpdateSelectedCriteria event, Emitter<ProgramDetailsState> emit) {
    final data = List<Map<String, dynamic>>.from(state.data!);
    final itemData = Map<String, dynamic>.from(data[event.outerIndex]);
    final selectedCriteria =
        List<String?>.from(itemData['selectedCriteria'] ?? []);
    // Ensure the list is long enough
    while (selectedCriteria.length <= event.criteriaIndex) {
      selectedCriteria.add(null);
    }
    selectedCriteria[event.criteriaIndex] = event.value;
    itemData['selectedCriteria'] = selectedCriteria;
    data[event.outerIndex] = itemData;
    add(AddDropdownCriteria(event.outerIndex));
    emit(state.copyWith(data: data));
  }

  void _onAddDropdownCriteria(
      AddDropdownCriteria event, Emitter<ProgramDetailsState> emit) {
    final data = List<Map<String, dynamic>>.from(state.data!);
    final itemData = Map<String, dynamic>.from(data[event.outerIndex]);
    final selectedCriteria =
        List<String?>.from(itemData['selectedCriteria'] ?? []);
    selectedCriteria.add(null);
    itemData['selectedCriteria'] = selectedCriteria;
    data[event.outerIndex] = itemData;
    emit(state.copyWith(data: data));
  }

  void _onSaveProgramDetails(
      SaveProgramDetails event, Emitter<ProgramDetailsState> emit) async {
    final itemData = state.data![0]; // Get the data from index 0 (initial item)
    String userId = PrefUtil.getString(PrefUtil.userId);

    if (userId == "") {
      Fluttertoast.showToast(
        msg: "User ID is missing!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Exit the function if userId is missing
    }

    log("UserId is $userId");

    final programData = {
      "userId": userId,
      'selectedItems': itemData['selectedItems'],
      'selectedIndicesByCategory': itemData['selectedIndicesByCategory'],
      'selectedCriteria': itemData['selectedCriteria'],
    };

    try {
      await _firestore
          .collection('program_details')
          .add(programData)
          .then((value) {
        log("Success store");
      });
      add(LoadProgramDetails());
      emit(state.copyWith(isSaved: true));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to save program details!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      log("Error storing program details: $e");
    }
  }

  void _onDeleteProgramDetails(
      DeleteProgramDetails event, Emitter<ProgramDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _firestore
          .collection('program_details')
          .doc(event.documentId)
          .delete();
      log("Document with ID ${event.documentId} deleted.");

      // Optionally, reload the data after deletion
      add(LoadProgramDetails());
    } catch (e) {
      log("Failed to delete document: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onUpdateProgramDetails(
      UpdateProgramDetails event, Emitter<ProgramDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _firestore
          .collection('program_details')
          .doc(event.documentId)
          .update(event.updatedData);

      log("Document with ID ${event.documentId} updated with data: ${event.updatedData}");

      // Optionally, reload the data after update
      add(LoadProgramDetails());
    } catch (e) {
      log("Failed to update document: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onToggleEditMode(
      ToggleEditMode event, Emitter<ProgramDetailsState> emit) {
    final isEditing = Map<int, bool>.from(state.isEditing);
    isEditing[event.index] =
        !(isEditing[event.index] ?? false); // Toggle edit mode

    log('Toggled edit mode for index ${event.index}. Is editing: ${isEditing[event.index]}');

    emit(state.copyWith(isEditing: isEditing));
  }
}
