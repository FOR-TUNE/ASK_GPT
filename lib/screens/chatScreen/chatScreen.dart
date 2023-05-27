// ignore_for_file: file_names
import 'package:ask_gpt/constants/sizeConfig.dart';
import 'package:ask_gpt/constants/styles.dart';
import 'package:ask_gpt/providers/chatMsgProvider.dart';
import 'package:ask_gpt/providers/isTypingProvider.dart';
import 'package:ask_gpt/screens/chatScreen/widgets/chatInputField.dart';
import 'package:ask_gpt/screens/chatScreen/widgets/chatMessages.dart';
import 'package:ask_gpt/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String routeName = '/Chat screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: secondaryBackgroundColor,
              title: Text(
                'Exit',
                style: kSubtitleText,
              ),
              content: Text(
                'Are you sure you want to exit the app?',
                style: kNormalText,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    onWillPop(context, false);
                  },
                  child: Text(
                    'Yes',
                    style: kNormalText,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: kNormalText.copyWith(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          shadowColor: textFieldColor.withOpacity(0.1),
          title: Text(
            'ASK GPT',
            style: kSubtitleText.copyWith(
              fontSize: 24,
            ),
          ),
          backgroundColor: secondaryColor.withOpacity(0.7),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await Services.showAPIKeyDialog(context: context);
              },
              icon: const Icon(
                Icons.more_vert_outlined,
                color: textColor,
              ),
            )
          ],
        ),
        backgroundColor: secondaryBackgroundColor,
        body: Consumer(
          builder: (context, ref, child) {
            bool isTyping = ref.read(isTypingProvider.notifier).state;
            var chat = ref.watch(chatProvider);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chat.getMsgList.length,
                        itemBuilder: (context, index) {
                          int reversedIndex =
                              chat.getMsgList.length - 1 - index;
                          return ChatMessages(
                            text: chat.getMsgList[reversedIndex].msg,
                            chatIndex: chat.getMsgList[reversedIndex].chatIndex,
                          );
                        },
                      ),
                    ),
                    if (isTyping) ...[
                      const SpinKitThreeBounce(
                        color: Colors.black,
                        size: 18,
                      ),
                    ],
                    addVerticalSp(10),
                    const ChatInputField(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  onWillPop(context, bool toggle) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return toggle;
  }
}
