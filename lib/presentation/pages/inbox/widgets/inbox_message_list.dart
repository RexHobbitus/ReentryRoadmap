import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/presentation/pages/inbox/widgets/inbox_empty_state.dart';

import '../inbox_cubit.dart';
import '../inbox_state.dart';
import 'message_item_widget.dart';

class InboxMessagesList extends StatelessWidget {
  final InboxCubit cubit;
  final bool isWeb;

  const InboxMessagesList({Key? key, required this.cubit, this.isWeb = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<InboxCubit, InboxState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.messages.isEmpty) {
            return const InboxEmptyState();
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                return InkWell(
                    onTap: () {
                      if (isWeb == true) {
                        cubit.selectedMessageIndex(index);
                      }
                      if (isWeb == false) {
                        cubit.navigatetoChatScreen();
                      }
                    },
                    child: MessageItem(
                      message: message,
                      isSelected: state.messageListIndex == index,
                      isWeb: isWeb,
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
