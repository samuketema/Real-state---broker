import 'package:flutter/material.dart';

/// A single global [ScaffoldMessengerKey] that can be used anywhere in the
/// application to show snack bars without needing a [BuildContext].
///
/// The key is attached to the [MaterialApp] via the
/// `scaffoldMessengerKey` property in `main.dart`.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
