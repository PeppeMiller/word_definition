/// The word definition app home screen.
/// The home screen contains the content that the student
/// is reading.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/settings.dart';
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
          title: Row(
           children: [
             Expanded(
               child: Center(
                 // The name of the story being read
                 child: Text('Reading Aloud Research'),
               ),
             ),
             // Setup the audio toggle button
             Consumer<Settings>(
               builder: (context, settings, child) =>
                   IconButton(
                     icon: Icon(settings.getSoundOn() ? Icons.volume_up : Icons.volume_off),
                     tooltip: 'Toggle Audio',
                     onPressed: () {
                       settings.toggleSound();
                     },
                   ),
             ),
           ],
          )
        ),
        body: RichTextWithDefinition(),
      ),
    );
  }
}
