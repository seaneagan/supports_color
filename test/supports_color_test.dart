@TestOn('vm')
library supports_color.test;

import 'package:test/test.dart';
import 'package:supports_color/src/supports_color.dart';

main() {
  group('supportsColor', () {

    test('should return false if no terminal', () {
      expect(supportsColorTestable(hasTerminal: false, env: {'TERM': 'xterm'}), isFalse);
    });

    test('should return true if `COLORTERM` is in env', () {
      expect(supportsColorTestable(env: {'COLORTERM': 'xterm'}), isTrue);
    });

    test('should return false on unsupported terminals', () {
      expect(supportsColorTestable(env: {'TERM': 'dumb'}), isFalse);
      expect(supportsColorTestable(env: {'TERM': 'foo'}), isFalse);
    });

    test('should return true on supported terminals', () {
      expect(supportsColorTestable(env: {'TERM': 'screen'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'xterm'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'xterm-color'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'vt100'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'color'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'ansi'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'linux'}), isTrue);
    });

    test('should return true on cygwin mintty terminal even though there is no terminal', () {
      expect(supportsColorTestable(isWindows: true, hasTerminal: false, env: {'TERM': 'xterm'}), isTrue);
    });

    test('should return false on other windows terminals', () {
      // [Git Bash](http://msysgit.github.io/).
      expect(supportsColorTestable(isWindows: true, env: {'TERM': 'msys'}), isFalse);
      // Default cygwin terminal or Git Bash.
      expect(supportsColorTestable(isWindows: true, env: {'TERM': 'cygwin'}), isFalse);
      // cmd.exe, Powershell, etc.
      expect(supportsColorTestable(isWindows: true), isFalse);
    });

  });
}