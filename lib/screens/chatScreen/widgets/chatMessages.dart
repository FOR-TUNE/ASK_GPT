// ignore_for_file: file_names
import 'package:ask_gpt/constants/sizeConfig.dart';
import 'package:ask_gpt/constants/styles.dart';
import 'package:ask_gpt/screens/chatScreen/widgets/textWidget.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    required this.text,
    required this.chatIndex,
  });

  final String text;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenAwareSize(10, context),
      ),
      child: Align(
        alignment:
            chatIndex == 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenAwareSize(5, context, width: true),
          ),
          child: SizedBox(
            width: screenWidth(context) - 40,
            child: Column(
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  shadowColor: chatIndex == 0
                      ? textFieldColor.withOpacity(0.1)
                      : secondaryColor.withOpacity(0.1),
                  color: chatIndex == 0
                      ? secondaryColor.withOpacity(0.7)
                      : textFieldColor.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          chatIndex == 0
                              ? 'assets/logo/person.png'
                              : 'assets/logo/Ask_GPT_Logo.png',
                          height: 30.0,
                          width: 30.0,
                        ),
                        addHorizontalSp(8.0),
                        Expanded(
                          child: TextWidget(
                            msg: text,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
