/// The RichTextWithDefinition widget contains a story for a student
/// to read and allows any word to be clicked on to show
/// the definition.

// TODO: Pass in the name of the story and the story to read

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async' show Future;
import 'package:tokenizer/tokenizer.dart';
import 'dart:convert';

class RichTextWithDefinition extends StatefulWidget {
  const RichTextWithDefinition({
    Key key,
  }) : super(key: key);

  @override
  _RichTextWithDefinitionState createState() => _RichTextWithDefinitionState();
}

class _RichTextWithDefinitionState extends State<RichTextWithDefinition> {
  var _dictionary;

  @override
  Widget build(BuildContext context) {
    Future loadAssets(BuildContext context) async {
      final storyText =
          await DefaultAssetBundle.of(context).loadString('./assets/story.txt');
      var dictionaryText =
          await DefaultAssetBundle.of(context).loadString('./assets/dictionary.json');

      // TODO: Support multi-word definitions.
      _dictionary = Map.fromIterable(jsonDecode(dictionaryText),
          key: (k) => k['name'].toLowerCase(),
          value: (v) => v['data']);

      // Tokenize our story
      final tokenizer = Tokenizer({',', ' ', '\r\n', '“', '”', '.'});
      final tokens = tokenizer.tokenize(storyText).map((e) => e.value);

      return tokens;
    }

    return FutureBuilder(
        future: loadAssets(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildContent(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  List<InlineSpan> _buildRichText(tokens) {
    final textSpans = List<InlineSpan>();
    final style = TextStyle(color: Colors.black);

    for (final token in tokens) {
      if (_dictionary.containsKey(token.toLowerCase())) {
        textSpans.add(TextSpan(
          style: style,
          text: token,
          recognizer: TapGestureRecognizer()..onTap = () {
            _showDefinition(token);
          }
        ),
        );
      }
      else {
        textSpans.add(TextSpan(
            style: style,
            text: token,
        ),
        );
      }
    }

    return textSpans;
  }

  Widget _buildContent(tokens) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(children: _buildRichText(tokens)),
      ),
    );
  }

  void _showDefinition(word) {
    // TODO - Instead of using the first entry, lookup the proper
    //  part of speech and correct entry
    // TODO: Filter by the grade level of the current student.
    final entry = _dictionary[word.toLowerCase()][0];

    final player = AudioPlayer();
    print(entry['audio']);
    player.play(entry['audio']);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Center(
              child: Text(entry['title']),
            ),
            content: Text(entry['definition'])
          ),
    );
  }
}
