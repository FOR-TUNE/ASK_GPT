// ignore_for_file: file_names
import 'package:ask_gpt/constants/sizeConfig.dart';
import 'package:ask_gpt/constants/styles.dart';
import 'package:ask_gpt/providers/chatMsgProvider.dart';
import 'package:ask_gpt/providers/isTypingProvider.dart';
import 'package:ask_gpt/screens/chatScreen/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(
        toString(),
      );
}

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late TextEditingController _controller = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Future<void> sendMessage() async {
          if (_controller.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: TextWidget(
                  msg: "Please type a message",
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          } else {
            try {
              String usermsg = _controller.text;
              ref.read(isTypingProvider.notifier).state = true;
              ref.read(chatProvider.notifier).addUserMessage(
                    msg: usermsg,
                  );
              _controller.clear();
              focusNode.unfocus();
            } catch (error) {
              error.log();
            } finally {
              ref.read(isTypingProvider.notifier).state = false;
            }
          }
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Material(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: textColor,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: textColor),
                          controller: _controller,
                          maxLines: null,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Ask me anything!",
                            hintStyle: TextStyle(color: textColor),
                          ),
                          focusNode: focusNode,
                          onSubmitted: (value) {},
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          sendMessage();
                        },
                        icon: Transform.rotate(
                          angle: 320,
                          child: const Icon(
                            Icons.send,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSp(5),
              const Text(
                'Making AI systems more natural and safe to interact with. \nAsk GPT any question Today',
                style: TextStyle(
                  color: textColor,
                  fontSize: 10.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
