/// The definition dialog is the popup that shows the definition
/// for a word.  Calling showDefinition and passing it the word
/// to show will cause the dialog to popup, returning a
/// Future to be completed when the dialog is closed.

import 'package:provider/provider.dart';
import 'package:word_definition/model/student_dictionary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void showDefinition(String word, context) {
  // TODO - Instead of using the first entry, lookup the proper
  //  part of speech and correct entry
  // TODO: Filter by the grade level of the current student.
  final dictionary = Provider.of<StudentDictionary>(context, listen:false);

  final entry = dictionary.getWord(word);

  // TODO: Make this optional.
  try {
    final player = AudioPlayer();
    player.play(entry.audioUrl);
  }
  catch (e) {
    print(e);
  }

  showDialog(
    context: context,
    builder: (_) =>
        AlertDialog(
            title: Center(
              child: Text(entry.title),
            ),
            content: Text(entry.definition),
        ),
  );
}
