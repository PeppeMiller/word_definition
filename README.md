# word_definition

The String Processing Project.

## Details

If you click or touch a word it will show you the definition and play the audio clip.  Not every
word has a definition, common words like "the" and "that" are purposefully excluded.  As such,
they are not clickable.  The could be easily be included by adding an entry in the json file.

This was tested in Chrome and and Android emulator.

## Next technical steps

There are a number of improvements needed for this to become a production ready product:

* Move from a JSON file to a server side database.  When a story is loaded, generate the dictionary then.
* Begin using parts of speech and definition entry tags.  A story needs to be parsed to match each word to the appropriate definition, such as which "chair" is being used.
* To generate parsings of a story, I would first try to use Mechanical Turk.  I would send the context,  word, and list of definitions to the turk and ask them to select the appropriate definition.
* The age appropriate definitions should be used.  Someone reading at a college level would need different definitions than someone reading at an early reader level.
* Move to a multimedia format for the definitions.  Instead of defining "dinosaur", show one.  Maybe an animation of one.
* Support multi-word definitions, such as "Department Chair"
