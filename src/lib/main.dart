
import 'package:flutter/material.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Simple App',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			home: AuthWrapper(),
		);
	}
}

class AuthWrapper extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (_) => AuthCubit(),
			child: BlocBuilder<AuthCubit, AuthState>(
				builder: (context, state) {
					if (state is AuthSuccess) {
						return HomeScreen();
					} else {
						return LoginScreen();
					}
				},
			),
		);
	}
}
