part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final String displayName;

  const UpdateUserEvent({required this.displayName});

  @override
  List<Object> get props => [displayName];
}
