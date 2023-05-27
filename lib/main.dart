import 'package:ask_gpt/constants/styles.dart';
import 'package:ask_gpt/routes.dart';
import 'package:ask_gpt/screens/splashScreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


void main() {
  runApp(
    const ProviderScope(
      child: AskGPT(),
    ),
  );
}

class AskGPT extends ConsumerWidget {
  const AskGPT({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ask GPT',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: textColor),
          backgroundColor: secondaryColor,
        ),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: secondaryBackgroundColor,
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
