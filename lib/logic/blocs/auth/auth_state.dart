part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInit extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [];
}

class DeAuth extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFail extends AuthState {
  final String errMsg;

  AuthFail({required this.errMsg});

  @override
  List<Object?> get props => [errMsg];
}
