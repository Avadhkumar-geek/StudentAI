part of 'custom_app_bloc.dart';

class CustomAppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomAppStateInitial extends CustomAppState {}

class CustomAppStateLoading extends CustomAppState {}

class CustomAppStateLoaded extends CustomAppState {
  final List<CustomAppModel> apps;

  CustomAppStateLoaded({required this.apps});

  @override
  List<Object?> get props => [apps];
}

class CustomAppStateUpdated extends CustomAppState {
  @override
  List<Object?> get props => [];
}

class CustomAppStateFailed extends CustomAppState {
  final String error;

  CustomAppStateFailed({this.error = 'Something went wrong'});

  @override
  List<Object?> get props => [error];
}
