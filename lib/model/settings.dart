/// Application settings

import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  /// Should we play audio
  var _soundOn = true;

  /// Toggle audio being enabled.
  void toggleSound() {
    _soundOn = !_soundOn;
    notifyListeners();
  }

  /// Check if audio is enabled.
  bool getSoundOn() {
    return _soundOn;
  }
}
