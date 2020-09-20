/// A single entry for a word definition.
class WordDefinition {
  /// The part of speech tag for this definition
  final String partOfSpeech;
  /// The definition entry (1st noun definition, 2nd noun definition, etc..)
  final int entryIndex;
  /// The title to display on the dialog
  final String title;
  /// The definition to display for this word
  final String definition;
  /// The audio clip definition to play for this word
  final String audioUrl;
  /// The HTML definition to render for this word
  final String definitionHtml;

  WordDefinition(this.partOfSpeech, this.entryIndex, this.title,
      this.definition, this.audioUrl, this.definitionHtml);

  WordDefinition.fromJson(Map<String, dynamic> json)
      : partOfSpeech = json['pos'],
        entryIndex = json['entry'],
        title = json['title'],
        definition = json['definition'],
        audioUrl = json['audio'],
        definitionHtml = json['definitionHtml'];
}
