import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/chat_reply_list_model.dart';
import 'chat_initial_params.dart';
import 'chat_state.dart';
import 'chat_navigator.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatNavigator navigator;

  ChatCubit({required this.navigator}) : super(ChatState.initial());

  BuildContext get context => navigator.context;

  void toggleReplying(bool value) {
    emit(state.copyWith(isReplying: value));
  }

  void addReply(ChatReplyListModel reply) {
    final updatedReplies = List<ChatReplyListModel>.from(state.replies)
      ..add(reply);
    emit(state.copyWith(replies: updatedReplies));
  }

  void onInit(ChatInitialParams initialParams) {}
}
