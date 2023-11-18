part of 'api_bloc.dart';

abstract class APIEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class APIRequestEvent extends APIEvent {
  final String query;

  APIRequestEvent({required this.query});
}
