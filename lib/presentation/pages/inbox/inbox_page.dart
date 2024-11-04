import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/inbox/inbox_state.dart';
import 'package:reentry_roadmap/presentation/pages/inbox/widgets/inbox_empty_state.dart';
import 'package:reentry_roadmap/presentation/pages/inbox/widgets/inbox_search_feild.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/custom_responsive_builder.dart';
import 'inbox_cubit.dart';
import 'inbox_initial_params.dart';
import 'widgets/message_header.dart';
import 'widgets/message_item_widget.dart';
import 'widgets/message_tab_selector.dart';

class InboxPage extends StatefulWidget {
  final InboxCubit cubit;
  final InboxInitialParams initialParams;

  static const path = '/InboxPage';

  const InboxPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxState();
}

class _InboxState extends State<InboxPage> {
  InboxCubit get cubit => widget.cubit;

  bool isMobileView = true;
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
      body:
          CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
        return deviceSize == DeviceSize.mobile
            ? Padding(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MessageHeader(title: "Messages"),
                    const SizedBox(height: 20),
                    const InboxSearchField(),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 15),
                    BlocBuilder<InboxCubit, InboxState>(
                      bloc: cubit,
                      builder: (context, state) {
                        return MessageTabSelector(
                          selectedIndex: state.selectedIndex,
                          onSelectTab: (index) => cubit.onSelectTab(index),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: BlocBuilder<InboxCubit, InboxState>(
                        bloc: cubit,
                        builder: (context, state) {
                          return state.messages.isEmpty
                              ? const InboxEmptyState()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.messages.length,
                                  itemBuilder: (context, index) {
                                    final message = state.messages[index];

                                    return GestureDetector(
                                        onTap: () {
                                          cubit.navigatetoChatScreen();
                                        },
                                        child: MessageItem(message: message));
                                  },
                                );
                        },
                      ),
                    )

                    // You can add other widgets below this line (like message list)
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 420,
                            child: Column(
                              children: [
                                const MessageHeader(title: "Messages"),
                                const SizedBox(height: 20),
                                const InboxSearchField(),
                                const SizedBox(height: 15),
                                const Divider(),
                                const SizedBox(height: 15),
                                BlocBuilder<InboxCubit, InboxState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    return MessageTabSelector(
                                      selectedIndex: state.selectedIndex,
                                      onSelectTab: (index) =>
                                          cubit.onSelectTab(index),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: BlocBuilder<InboxCubit, InboxState>(
                                    bloc: cubit,
                                    builder: (context, state) {
                                      return state.messages.isEmpty
                                          ? const InboxEmptyState()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.messages.length,
                                              itemBuilder: (context, index) {
                                                final message =
                                                    state.messages[index];

                                                return MessageItem(
                                                    message: message);
                                              },
                                            );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          VerticalDivider(
                            thickness: 0.5,
                            color: Theme.of(context).disabledColor,
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select a message to read it",
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "You have 3 unread messages",
                                    style: context.textTheme.titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
