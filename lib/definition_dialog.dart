/// The definition dialog is the popup that shows the definition
/// for a word.  Calling showDefinition and passing it the word
/// to show will cause the dialog to popup, returning a
/// Future to be completed when the dialog is closed.

import 'package:provider/provider.dart';
import 'model/student_dictionary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'model/settings.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

void showDefinition(String word, context) {
  // TODO - Instead of using the first entry, lookup the proper
  //  part of speech and correct entry
  // TODO: Filter by the grade level of the current student.
  final dictionary = Provider.of<StudentDictionary>(context, listen: false);

  final entry = dictionary.getWord(word);
  final player = AudioPlayer();
  var playAudio = false;

  final settings = Provider.of<Settings>(context, listen: false);

  // Play some audio if audio is enabled
  try {
    if (settings.getSoundOn()) {
      player.play(entry.audioUrl);
      playAudio = true;
    }
  } catch (e) {
    print(e);
  }

  // Show the dialog for the definition.
  showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
            image: Image.asset('assets/letters.jpg', fit: BoxFit.fill),
            title: Text(
              entry.title,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: Text(
              entry.definition,
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            // entryAnimation: EntryAnimation.BOTTOM,
            onlyOkButton: true,
            onOkButtonPressed: () {
              // Handle shutting down if the "ok" button was pressed
              if (playAudio) {
                playAudio = false;
                player.stop();
              }
              Navigator.of(context).pop();
            },
          )).
  then((param) {
    // Handle stopping the audio if you click away from the dialog, not
    // clicking "ok"
    if (playAudio) {
      player.stop();
    }
  });
}
