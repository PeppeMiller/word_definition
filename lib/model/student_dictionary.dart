/// The contents of the student dictionary.

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';

/// A single entry for a word definition.
class WordDefinition {
  final String partOfSpeech;
  final int entryIndex;
  final String title;
  final String definition;
  final String audioUrl;

  WordDefinition(this.partOfSpeech, this.entryIndex, this.title,
      this.definition, this.audioUrl);

  WordDefinition.fromJson(Map<String, dynamic> json)
    : partOfSpeech = json['pos'],
      entryIndex = json['entry'],
      title = json['title'],
      definition = json['definition'],
      audioUrl = json['audio'];
}

/// Utility class to lookup word definition data.
class StudentDictionary extends ChangeNotifier {

  final _dictionary = {};
  var _built = false;

  void loadDictionary(context) async {
    DefaultAssetBundle.of(context).loadString('./assets/dictionary.json')
    .then((dictionaryText) {
      // TODO: Support multi-word definitions.
      _dictionary.addAll(Map.fromIterable(jsonDecode(dictionaryText),
          key: (k) => k['name'].toLowerCase(),
          value: (v) => WordDefinition.fromJson(v['data'][0])));

      // Update the consumers that our dictionary is ready
      _built = true;
      notifyListeners();
    });

  }

  bool wordIsInDictionary(String word) {
    // Ensure we're done loading.
    if (!_built) {
      return false;
    }

    return _dictionary.containsKey(word.toLowerCase());
  }

  WordDefinition getWord(String word) {
    if (wordIsInDictionary(word)) {
      return _dictionary[word.toLowerCase()];
    }

    return null;
  }

}