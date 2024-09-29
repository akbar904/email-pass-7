
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/screens/home/home_screen.dart';

// Mock dependencies if any (e.g., Cubit)
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays logout button', (WidgetTester tester) async {
			// Build our app and trigger a frame.
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);
			
			// Verify that the logout button is present.
			expect(find.text('Logout'), findsOneWidget);
		});
	});

	group('HomeScreen Cubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits AuthInitial when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthInitial()],
		);
	});
}
