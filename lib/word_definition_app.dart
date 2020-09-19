/// Main app class for the word definition application.

import 'package:flutter/material.dart';
import 'home_screen.dart';

class WordDefinitionApp extends StatelessWidget {
  const WordDefinitionApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
