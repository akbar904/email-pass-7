
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_app/models/user.dart';

void main() {
	group('User Model', () {
		test('should correctly serialize from JSON', () {
			final json = {
				'email': 'test@example.com',
				'id': '12345',
			};

			final user = User.fromJson(json);

			expect(user.email, 'test@example.com');
			expect(user.id, '12345');
		});

		test('should correctly deserialize to JSON', () {
			final user = User(
				email: 'test@example.com',
				id: '12345',
			);

			final json = user.toJson();

			expect(json['email'], 'test@example.com');
			expect(json['id'], '12345');
		});

		test('should correctly create User instance', () {
			final user = User(
				email: 'test@example.com',
				id: '12345',
			);

			expect(user.email, 'test@example.com');
			expect(user.id, '12345');
		});
	});
}
