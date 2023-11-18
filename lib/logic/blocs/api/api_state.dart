part of 'api_bloc.dart';

abstract class APIState extends Equatable {}

class APIInitState extends APIState {
  @override
  List<Object?> get props => [];
}

class APIRequestState extends APIState {
  final String query;

  APIRequestState({required this.query});

  @override
  List<Object?> get props => [];
}

class APISuccessState extends APIState {
  final String response;

  APISuccessState({required this.response});

  @override
  List<Object?> get props => [];
}

class APIFailedState extends APIState {
  final String error;

  APIFailedState({required this.error});
  @override
  List<Object?> get props => [];
}
