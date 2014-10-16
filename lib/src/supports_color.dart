
library supports_color.impl;

import 'dart:io';

/// Detect whether the current terminal supports color.
bool get supportsColor {
  if(_supportsColor == null) {
    _supportsColor = supportsColorTestable(
        hasTerminal: stdout.hasTerminal, 
        isWindows: Platform.isWindows, 
        env: Platform.environment);
  }
  return _supportsColor;
}
bool _supportsColor;

bool supportsColorTestable({
    bool hasTerminal: true, 
    bool isWindows: false, 
    Map<String, String> env: const {}}) {
  
  if (!hasTerminal) {
    return false;
  }
  
  var term = env['TERM'];
  bool supportsTerm() => term != null && term != 'dumb' && _termPattern.hasMatch(term);
  
  if (isWindows) {
    // TODO: Change to `true` once http://dartbug.com/21337 is fixed.
    // Cygwin support.
    return supportsTerm();
  }

  if (env.containsKey('COLORTERM')) {
    return true;
  }

  if (supportsTerm()) {
    return true;
  }

  return false;
}
final _termPattern = new RegExp(r'^screen|^xterm|^vt100|color|ansi|cygwin|linux', caseSensitive: false);
