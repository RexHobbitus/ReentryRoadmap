import 'package:flutter/material.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../main/explore/explore_navigator.dart';
import 'chat_page.dart';
import 'chat_initial_params.dart';

class ChatNavigator with ExploreRoute {
  ChatNavigator(this.navigator);

  late BuildContext context;

  late AppNavigator navigator;
}

mixin ChatScreenRoute {
  openChatScreen(ChatInitialParams initialParams) {
    navigator.push(context, ChatPage.path, initialParams);
  }

  AppNavigator get navigator;

  BuildContext get context;
}
