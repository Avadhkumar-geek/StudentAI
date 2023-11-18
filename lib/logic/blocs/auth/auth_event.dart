part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LogInEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
