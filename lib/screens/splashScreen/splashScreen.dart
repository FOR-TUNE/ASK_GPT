// ignore_for_file: file_names
import 'dart:async';
import 'package:ask_gpt/constants/sizeConfig.dart';
import 'package:ask_gpt/constants/styles.dart';
import 'package:ask_gpt/screens/chatScreen/chatScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    // Start loading process
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulate a long-running operation
    for (int i = 0; i < 4; i++) {
      await Future.delayed(
        const Duration(
          seconds: 4,
        ),
      );
      setState(
        () {
          _progressValue = (i + 1) / 4; // Update progress value
        },
      );
    }
    // Loading complete, navigate to next screen
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(
      ChatScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/logo/gpt_logo.png',
                scale: 2.0,
                height: screenAwareSize(150, context),
                width: screenAwareSize(100, context, width: true),
              ),
              addVerticalSp(15),
              Text('ASK GPT', style: kTitleText)
            ],
          ),
          Center(
            child: SizedBox(
              width: screenAwareSize(
                150,
                context,
                width: true,
              ),
              child: LinearProgressIndicator(
                value: _progressValue,
                color: textColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
