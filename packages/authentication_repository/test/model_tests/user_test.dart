import 'package:authentication_repository/authentication_repository.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock-email';
    
    test('uses value equality', () {
      expect(User(id: id, email: email),
          equals(User(id: id, email: email)));
    });

    test('isEmpty return true when user is empty', () {
      expect(User.empty.isEmpty, isTrue);
    });

    test('isEmpty return false for an non-empty user', () {
      expect(User(id: id, email: email).isEmpty, false);
    });

    test('isNotEmpty return false for an empty user', () {
      expect(User.empty.isNotEmpty, false);
    });

    test('isNotEmpty return true for an non-empty user', () {
      expect(User(id: id, email: email).isNotEmpty, true);
    });

  });
}

