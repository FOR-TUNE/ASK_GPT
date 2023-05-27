import 'package:ask_gpt/screens/chatScreen/chatScreen.dart';
import 'package:ask_gpt/screens/splashScreen/splashScreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  ChatScreen.routeName:(context) => const ChatScreen(),
};
