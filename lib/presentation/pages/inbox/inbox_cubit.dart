import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/chat_initial_params.dart';
import '../../../data/models/inbox_messages_model.dart';
import 'inbox_initial_params.dart';
import 'inbox_state.dart';
import 'inbox_navigator.dart';
import 'widgets/inbox_datetime_format.dart';

class InboxCubit extends Cubit<InboxState> {
  final InboxNavigator navigator;

  InboxCubit({
    required this.navigator,
  }) : super(InboxState.initial());

  BuildContext get context => navigator.context;

  // Method to handle tab selection
  void onSelectTab(int index) async {
    List<InboxMessagesModel> filteredMessages;

    if (index == 0) {
      filteredMessages =
          InboxUtils.messages.where((message) => !message.isRead!).toList();
    } else {
      filteredMessages = InboxUtils.messages;
    }

    emit(state.copyWith(selectedIndex: index, messageFilter: filteredMessages));
  }

  navigatetoChatScreen() async {
    try {
      emit(state.copyWith(loading: true));
      navigator.openChatScreen(const ChatInitialParams());
    } catch (e) {
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  onInit(InboxInitialParams initialParams) {}
}
