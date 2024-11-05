import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/chat_state.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/widget/reply_widget.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/header_logo.dart';
import 'chat_cubit.dart';
import 'chat_initial_params.dart';
import 'widget/action_bar.dart';
import 'widget/reply_input_widget.dart';

class ChatPage extends StatefulWidget {
  final ChatCubit cubit;
  final ChatInitialParams initialParams;

  static const path = '/ChatPage';
  const ChatPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatPage> {
  ChatCubit get cubit => widget.cubit;
  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          leading: LayoutBuilder(builder: (context, constraints) {
            debugPrint("Leading layout ${constraints.maxWidth.toString()}");
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderLogo(),
              ],
            );
          }),
        ),
        body: Column(
          children: [
            ActionBar(
              onBackPressed: () {
                Navigator.of(context).pop();
              },
              onReplyPressed: () {},
              onDeletePressed: () {},
              onMarkAsUnreadPressed: () {},
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(kScreenHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title of this mail could in theory be very long",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                bloc: cubit,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(kScreenHorizontalPadding),
                    child: ListView.builder(
                      itemCount: state.replies.length,
                      itemBuilder: (BuildContext context, int index) {
                        final reply = state.replies[index];
                        return ReplyWidget(
                          cubit: cubit,
                          reply: reply,
                          isLastReply: index == state.replies.length - 1,
                          isReplying: state.isReplying,
                          onReplyToggle: () {
                            cubit.toggleReplying(true);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
