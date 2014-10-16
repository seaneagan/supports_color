
library supports_color.test;

import 'package:supports_color/src/supports_color.dart';
import 'package:unittest/unittest.dart';

main() {
  group('supportsColor', () {

    test('should return false if no terminal', () {
      expect(supportsColorTestable(hasTerminal: false, env: {'TERM': 'xterm'}), isFalse);
    });

    test('should check TERM on windows', () {
      expect(supportsColorTestable(isWindows: true, env: {'TERM': 'xterm'}), isTrue);
      expect(supportsColorTestable(isWindows: true, env: {'TERM': 'cygwin'}), isTrue);
      expect(supportsColorTestable(isWindows: true), isFalse);
    });

    test('should return true if `COLORTERM` is in env', () {
      expect(supportsColorTestable(env: {'COLORTERM': 'xterm'}), isTrue);
    });

    test('should return false on unsupported terminals', () {
      expect(supportsColorTestable(env: {'TERM': 'dumb'}), isFalse);
      expect(supportsColorTestable(env: {'TERM': 'foo'}), isFalse);
    });

    test('should return true on unsupported terminals', () {
      expect(supportsColorTestable(env: {'TERM': 'screen'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'xterm'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'xterm-color'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'vt100'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'color'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'ansi'}), isTrue);
      expect(supportsColorTestable(env: {'TERM': 'linux'}), isTrue);
    });
  });
}