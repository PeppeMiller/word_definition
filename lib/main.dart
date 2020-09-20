/// The is the main entry point for the word definition app.

import 'package:flutter/material.dart';
import 'word_definition_app.dart';
import 'package:provider/provider.dart';
import 'model/student_dictionary.dart';

// TODO: Document better.
// TODO: Add image background.
// TODO: Improve font.
// TODO: Improve dialog box.

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) {
      final dictionary = StudentDictionary();
      dictionary.loadDictionary(context);
      return dictionary;
    },
    child: WordDefinitionApp(),
    )
  );
}
