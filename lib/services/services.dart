// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:ask_gpt/constants/sizeConfig.dart';
import 'package:ask_gpt/constants/styles.dart';
import 'package:ask_gpt/screens/chatScreen/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class Services {
  static Future<void> showAPIKeyDialog({required BuildContext context}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const APIKeyDialogWidget();
      },
    );
  }
}

class APIKeyDialogWidget extends StatefulWidget {
  const APIKeyDialogWidget({
    super.key,
  });

  @override
  State<APIKeyDialogWidget> createState() => _APIKeyDialogWidgetState();
}

class _APIKeyDialogWidgetState extends State<APIKeyDialogWidget> {
  TextEditingController pasteController = TextEditingController();
  String apiKey = '';
  @override
  void dispose() {
    pasteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      elevation: 2.0,
      backgroundColor: secondaryColor.withOpacity(0.7),
      shadowColor: textFieldColor.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenAwareSize(12, context, width: true),
          vertical: screenAwareSize(20, context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            addVerticalSp(10),
            Text(
              'Generate an API Key',
              style: kSubtitleText.copyWith(
                fontSize: 20,
              ),
            ),
            addVerticalSp(5),
            Text(
              'To chat with me, get an API key from OpenAI. Follow the link below and generate a key.\n "https://platform.openai.com/account/api-keys"'
              'Then enter the key in our app to start chatting',
              style: kNormalText,
            ),
            addVerticalSp(20),
            Text(
              'After copied your Api key paste and save it here',
              style: kNormalText,
            ),
            addVerticalSp(10),
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                floatingLabelStyle: kNormalText,
                labelText: 'Paste your API Key',
                labelStyle: kNormalText,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final clipPaste =
                        await Clipboard.getData(Clipboard.kTextPlain);
                    final text = clipPaste == null ? '' : clipPaste.text!;
                    setState(
                      () {
                        pasteController.text = text;
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.content_paste,
                    color: textColor,
                    size: 12.0,
                  ),
                ),
              ),
              controller: pasteController,
            ),
            addVerticalSp(15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: textFieldColor.withOpacity(0.6),
                fixedSize: const Size(100, 40),
                elevation: 5.0,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('ApiKey', pasteController.text);
                if (pasteController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const TextWidget(
                        msg: "Please key in your API Key.",
                      ),
                      backgroundColor: secondaryColor.withOpacity(0.7),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.transparent,
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      duration: const Duration(seconds: 2),
                      content: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenAwareSize(10, context, width: true),
                          vertical: screenAwareSize(10, context),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              height: screenAwareSize(120, context),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Success', style: kNormalText),
                                  addVerticalSp(5),
                                  Text(
                                    'Your OpenAI API key has been saved successfully. You wont need to enter it again in the future...',
                                    style: kNormalText.copyWith(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  Timer(
                    const Duration(seconds: 3),
                    () => Navigator.of(context).pop(),
                  );
                }
              },
              child: Text(
                'Save',
                style: kNormalText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
