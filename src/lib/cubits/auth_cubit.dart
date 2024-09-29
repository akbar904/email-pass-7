
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// States
abstract class AuthState extends Equatable {
	const AuthState();
	
	@override
	List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
	final String message;
	
	const AuthFailure(this.message);
	
	@override
	List<Object> get props => [message];
}

// Cubit
class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());
	
	void login(String email, String password) async {
		emit(AuthLoading());
		await Future.delayed(Duration(seconds: 1)); // Simulate network delay
		
		if (email == 'test@example.com' && password == 'password') {
			emit(AuthSuccess());
		} else {
			emit(AuthFailure('Login failed'));
		}
	}
	
	void logout() {
		emit(AuthInitial());
	}
}
