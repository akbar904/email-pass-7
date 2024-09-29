
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc/bloc.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'emit AuthSuccess on successful login',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), AuthSuccess()],
		);

		blocTest<AuthCubit, AuthState>(
			'emit AuthFailure on failed login',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'password'),
			expect: () => [AuthLoading(), AuthFailure('Login failed')],
		);

		blocTest<AuthCubit, AuthState>(
			'emit AuthInitial on logout',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthInitial()],
		);
	});
}
