import 'package:flutter_riverpod/flutter_riverpod.dart';

// Global app providers will be defined here
// Example: Authentication state, theme mode, etc.

final themeProvider =
    StateProvider<bool>((ref) => false); // false = light, true = dark
