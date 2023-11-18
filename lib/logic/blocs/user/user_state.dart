part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserSuccessState extends UserState {
  final UserModel userData;

  const UserSuccessState({required this.userData});

  @override
  List<Object> get props => [userData];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserUpdatedState extends UserState {
  @override
  List<Object> get props => [];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
