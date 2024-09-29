
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App shows LoginScreen initially', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.text('Login'), findsOneWidget);
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('App navigates to HomeScreen on successful login', (tester) async {
			final mockAuthCubit = MockAuthCubit();

			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthInitial(), AuthSuccess()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(MyApp());

			// Trigger login
			await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'password');
			await tester.tap(find.byKey(Key('loginButton')));
			await tester.pumpAndSettle();

			expect(find.text('Home'), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('App navigates back to LoginScreen on logout', (tester) async {
			final mockAuthCubit = MockAuthCubit();

			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthSuccess(), AuthInitial()]),
				initialState: AuthSuccess(),
			);

			await tester.pumpWidget(MyApp());

			// Trigger logout
			await tester.tap(find.byKey(Key('logoutButton')));
			await tester.pumpAndSettle();

			expect(find.text('Login'), findsOneWidget);
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});
	});
}
