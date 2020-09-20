/// The RichTextWithDefinition widget contains a story for a student
/// to read and allows any word to be clicked on to show
/// the definition.

// TODO: Pass in the name of the story and the story to read
// TODO: Break this file up.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:async' show Future;
import 'package:tokenizer/tokenizer.dart';
import 'package:word_definition/definition_dialog.dart';
import 'package:word_definition/model/student_dictionary.dart';

class RichTextWithDefinition extends StatefulWidget {
  const RichTextWithDefinition({
    Key key,
  }) : super(key: key);

  @override
  _RichTextWithDefinitionState createState() => _RichTextWithDefinitionState();
}

class _RichTextWithDefinitionState extends State<RichTextWithDefinition> {

  @override
  Widget build(BuildContext context) {
    Future loadAssets(BuildContext context) async {
      final storyText =
          await DefaultAssetBundle.of(context).loadString('./assets/story.txt');

      // Tokenize our story
      final tokenizer = Tokenizer({',', ' ', '\r\n', '“', '”', '.'});
      final tokens = tokenizer.tokenize(storyText).map((e) => e.value);

      return tokens;
    }

    return FutureBuilder(
        future: loadAssets(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<StudentDictionary>(
              builder: (context, dictionary, child) => _buildContent(context, snapshot.data, dictionary),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  List<InlineSpan> _buildRichText(context, tokens, StudentDictionary dictionary) {
    final textSpans = List<InlineSpan>();
    final style = TextStyle(color: Colors.black);

    for (final token in tokens) {
      if (dictionary.wordIsInDictionary(token)) {
        textSpans.add(TextSpan(
          style: style,
          text: token,
          recognizer: TapGestureRecognizer()..onTap = () {
            showDefinition(token, context);
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

  Widget _buildContent(context, tokens, StudentDictionary dictionary) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(children: _buildRichText(context, tokens, dictionary)),
      ),
    );
  }

}
