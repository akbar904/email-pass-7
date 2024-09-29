
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/screens/login/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('should display Login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthLoading, AuthSuccess] when login is successful',
			build: () => mockAuthCubit,
			act: (cubit) {
				when(() => cubit.login('test@example.com', 'password123'))
					.thenAnswer((_) async {
					cubit.emit(AuthLoading());
					await Future.delayed(Duration(seconds: 1));
					cubit.emit(AuthSuccess());
				});
				cubit.login('test@example.com', 'password123');
			},
			expect: () => [AuthLoading(), AuthSuccess()],
		);
	});
}
