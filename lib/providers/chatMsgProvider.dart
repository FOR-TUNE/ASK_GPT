// import 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'package:ask_gpt/models/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dummyMessages = [
  {
    'msg': "Hi, tell me about you",
    'index': 0,
  },
  {
    'msg':
        "Hi, I am AskGPT, your trusted AI assistant ready to answer all your questions and help you acheive all your dreams.",
    'index': 1
  },
  {
    'msg': "Okay, that is good, Thank you.",
    'index': 0,
  },
  {
    'msg': "You're welcome",
    'index': 1,
  },
];

class ChatMessageProvider extends ChangeNotifier {
  bool isTyping = false;
  List<ChatModel> msgList = [];
  List<ChatModel> get getMsgList {
    return msgList;
  }

  void addUserMessage({required String msg}) {
    msgList.add(
      ChatModel(
        msg: msg,
        chatIndex: 0,
      ),
    );
    notifyListeners();
  }
}

final chatProvider = ChangeNotifierProvider<ChatMessageProvider>(
  (ref) => ChatMessageProvider(),
);
