
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/cubits/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
				actions: [
					IconButton(
						icon: Icon(Icons.logout),
						onPressed: () {
							context.read<AuthCubit>().logout();
						},
					),
				],
			),
			body: Center(
				child: Text('Welcome to Home Screen'),
			),
		);
	}
}
