/// The word definition app home screen.
/// The home screen contains the content that the student
/// is reading.

import 'package:flutter/material.dart';
import 'rich_text_with_definition.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Definitions',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            // The name of the story being read
            child: Text('Reading Aloud Research'),
          ),
        ),
        body: RichTextWithDefinition(),
      ),
    );
  }
}
