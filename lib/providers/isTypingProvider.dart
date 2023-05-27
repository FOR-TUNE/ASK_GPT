// ignore_for_file: file_names
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// For loading builder in ProviderListener
final isTypingProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);