/// The contents of the student dictionary.

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:word_definition/model/word_definition.dart';

/// Utility class to lookup word definition data.
class StudentDictionary extends ChangeNotifier {

  final _dictionary = {};
  var _built = false;

  // Load the dictionary from assets
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

  /// Determine if a word exists in our dictionary.
  bool wordIsInDictionary(String word) {
    // Ensure we're done loading.
    if (!_built) {
      return false;
    }

    return _dictionary.containsKey(word.toLowerCase());
  }

  /// Gets the definition object for a word, returns null if the word does
  /// not exist in our dictionary.
  WordDefinition getWord(String word) {
    if (wordIsInDictionary(word)) {
      return _dictionary[word.toLowerCase()];
    }

    return null;
  }

}
